import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/payment.dart';
import '../models/week_summary.dart';
import '../models/labor_budget.dart';
import '../models/worker.dart';

class PaymentService extends ChangeNotifier {
  List<Payment> _payments = [];
  LaborBudget _budget = LaborBudget(totalBudget: 20000000, usedBudget: 15000000); // Default values
  final String _paymentsStorageKey = 'payments_data';
  final String _budgetStorageKey = 'labor_budget_data';
  bool _isLoading = false;
  
  List<Payment> get payments => _payments;
  LaborBudget get budget => _budget;
  bool get isLoading => _isLoading;
  
  // Initialize service
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await loadPayments();
      await loadBudget();
    } catch (e) {
      debugPrint('Error initializing payment service: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Load payments from storage
  Future<void> loadPayments() async {
    final prefs = await SharedPreferences.getInstance();
    final paymentsJson = prefs.getString(_paymentsStorageKey);
    
    if (paymentsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(paymentsJson);
      _payments = decodedJson.map((item) => Payment.fromJson(item)).toList();
      notifyListeners();
    }
  }
  
  // Load budget from storage
  Future<void> loadBudget() async {
    final prefs = await SharedPreferences.getInstance();
    final budgetJson = prefs.getString(_budgetStorageKey);
    
    if (budgetJson != null) {
      final dynamic decodedJson = jsonDecode(budgetJson);
      _budget = LaborBudget.fromJson(decodedJson);
      notifyListeners();
    }
  }
  
  // Save payments to storage
  Future<void> savePayments() async {
    final prefs = await SharedPreferences.getInstance();
    final paymentsJson = jsonEncode(_payments.map((payment) => payment.toJson()).toList());
    await prefs.setString(_paymentsStorageKey, paymentsJson);
  }
  
  // Save budget to storage
  Future<void> saveBudget() async {
    final prefs = await SharedPreferences.getInstance();
    final budgetJson = jsonEncode(_budget.toJson());
    await prefs.setString(_budgetStorageKey, budgetJson);
  }
  
  // Add a new payment
  Future<Payment> addPayment({
    required String workerId,
    required String weekCode,
    required DateTime date,
    required double rate,
    required double amount,
    required PaymentFrequency frequency,
    int? daysWorked,
    bool includesOvertime = false,
    bool isPaid = false,
    String? notes,
  }) async {
    final payment = Payment(
      id: const Uuid().v4(),
      workerId: workerId,
      date: date,
      weekCode: weekCode,
      rate: rate,
      amount: amount,
      frequency: frequency,
      daysWorked: daysWorked,
      includesOvertime: includesOvertime,
      isPaid: isPaid,
      notes: notes,
    );
    
    _payments.add(payment);
    
    // Update used budget if payment is marked as paid
    if (isPaid) {
      updateUsedBudget(amount);
    }
    
    await savePayments();
    notifyListeners();
    return payment;
  }
  
  // Update budget usage
  Future<void> updateUsedBudget(double amount) async {
    _budget = LaborBudget(
      totalBudget: _budget.totalBudget,
      usedBudget: _budget.usedBudget + amount,
    );
    await saveBudget();
    notifyListeners();
  }
  
  // Update budget total
  Future<void> updateTotalBudget(double newTotal) async {
    _budget = LaborBudget(
      totalBudget: newTotal,
      usedBudget: _budget.usedBudget,
    );
    await saveBudget();
    notifyListeners();
  }
  
  // Mark payment as paid
  Future<void> markPaymentAsPaid(String paymentId) async {
    final index = _payments.indexWhere((p) => p.id == paymentId);
    if (index != -1) {
      final payment = _payments[index];
      if (!payment.isPaid) {
        // Update budget only if it wasn't already paid
        updateUsedBudget(payment.amount);
      }
      
      final updatedPayment = Payment(
        id: payment.id,
        workerId: payment.workerId,
        date: payment.date,
        weekCode: payment.weekCode,
        rate: payment.rate,
        amount: payment.amount,
        frequency: payment.frequency,
        daysWorked: payment.daysWorked,
        includesOvertime: payment.includesOvertime,
        isPaid: true,
        notes: payment.notes,
      );
      
      _payments[index] = updatedPayment;
      await savePayments();
      notifyListeners();
    }
  }
  
  // Delete a payment
  Future<void> deletePayment(String paymentId) async {
    final payment = _payments.firstWhere((p) => p.id == paymentId);
    
    // If the payment was paid, subtract from used budget
    if (payment.isPaid) {
      _budget = LaborBudget(
        totalBudget: _budget.totalBudget,
        usedBudget: _budget.usedBudget - payment.amount,
      );
      await saveBudget();
    }
    
    _payments.removeWhere((payment) => payment.id == paymentId);
    await savePayments();
    notifyListeners();
  }
  
  // Get all payments for a specific worker
  List<Payment> getPaymentsForWorker(String workerId) {
    return _payments.where((payment) => payment.workerId == workerId).toList();
  }
  
  // Get all payments for a specific week
  List<Payment> getPaymentsForWeek(String weekCode) {
    return _payments.where((payment) => payment.weekCode == weekCode).toList();
  }
  
  // Get all payments for a date range
  List<Payment> getPaymentsForDateRange(DateTime start, DateTime end) {
    return _payments.where((payment) => 
      payment.date.isAfter(start.subtract(const Duration(days: 1))) && 
      payment.date.isBefore(end.add(const Duration(days: 1)))
    ).toList();
  }
  
  // Get week summary for a specific week
  WeekSummary getWeekSummary(String weekCode) {
    final weekPayments = getPaymentsForWeek(weekCode);
    
    if (weekPayments.isEmpty) {
      // Return empty summary if no payments found
      return WeekSummary(
        weekCode: weekCode,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        positionTotals: {},
        totalAmount: 0,
      );
    }
    
    // Calculate position totals
    final Map<String, double> positionTotals = {};
    double totalAmount = 0;
    
    for (var payment in weekPayments) {
      totalAmount += payment.amount;
    }
    
    // Find date range for the week
    weekPayments.sort((a, b) => a.date.compareTo(b.date));
    final startDate = weekPayments.first.date;
    final endDate = weekPayments.last.date;
    
    return WeekSummary(
      weekCode: weekCode,
      startDate: startDate,
      endDate: endDate,
      positionTotals: positionTotals,
      totalAmount: totalAmount,
    );
  }
  
  // Get all unique week codes
  List<String> getUniqueWeekCodes() {
    final weekCodes = _payments.map((payment) => payment.weekCode).toSet().toList();
    weekCodes.sort((a, b) => b.compareTo(a)); // Sort in descending order (newest first)
    return weekCodes;
  }
  
  // Get total paid amount for a worker
  double getTotalPaidForWorker(String workerId) {
    return _payments
      .where((payment) => payment.workerId == workerId && payment.isPaid)
      .fold(0, (sum, payment) => sum + payment.amount);
  }
  
  // Get total unpaid amount for a worker
  double getTotalUnpaidForWorker(String workerId) {
    return _payments
      .where((payment) => payment.workerId == workerId && !payment.isPaid)
      .fold(0, (sum, payment) => sum + payment.amount);
  }
  
  // Generate new week code
  String generateWeekCode() {
    final weekCodes = getUniqueWeekCodes();
    
    if (weekCodes.isEmpty) {
      return 'W001';
    }
    
    // Find the highest week number
    int highestWeekNum = 0;
    for (var code in weekCodes) {
      if (code.startsWith('W')) {
        final numString = code.substring(1);
        try {
          final num = int.parse(numString);
          if (num > highestWeekNum) {
            highestWeekNum = num;
          }
        } catch (_) {
          // Skip if not parsable
        }
      }
    }
    
    // Return the next week code
    return 'W${(highestWeekNum + 1).toString().padLeft(3, '0')}';
  }
} 