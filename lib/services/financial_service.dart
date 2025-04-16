import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/financial_summary.dart';
//import 'worker_service.dart';
import 'payment_service.dart';

class FinancialService extends ChangeNotifier {
  final PaymentService _paymentService;
  late FinancialSummary _summary;
  
  FinancialService(this._paymentService) {
    _initializeData();
  }
  
  FinancialSummary get summary => _summary;
  
  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    final summaryJson = prefs.getString('financial_summary');
    
    if (summaryJson != null) {
      final data = jsonDecode(summaryJson);
      final laborSpent = data['laborSpent'] ?? _calculateLaborSpent();
      final materialsSpent = data['materialsSpent'] ?? 55000000.0;
      final otherSpent = data['otherSpent'] ?? 12000000.0;
      final totalBudget = data['totalBudget'] ?? 200000000.0;
      final totalSpent = laborSpent + materialsSpent + otherSpent;
      
      _summary = FinancialSummary(
        totalBudget: totalBudget,
        laborBudget: data['laborBudget'] ?? 75000000,
        materialsBudget: data['materialsBudget'] ?? 100000000,
        otherBudget: data['otherBudget'] ?? 25000000,
        laborSpent: laborSpent,
        materialsSpent: materialsSpent,
        otherSpent: otherSpent,
        totalSpent: totalSpent,
        totalRemaining: totalBudget - totalSpent,
        percentageSpent: (totalSpent / totalBudget) * 100,
        laborPercentage: (laborSpent / totalSpent) * 100,
        materialsPercentage: (materialsSpent / totalSpent) * 100,
        otherPercentage: (otherSpent / totalSpent) * 100,
      );
    } else {
      // Default values
      _summary = FinancialSummary(
        totalBudget: 200000000,
        laborBudget: 75000000,
        materialsBudget: 100000000,
        otherBudget: 25000000,
        laborSpent: _calculateLaborSpent(),
        materialsSpent: 55000000,
        otherSpent: 12000000,
        totalSpent: 24000000,
        totalRemaining: 200000000 - 24000000,
        percentageSpent: 12.0,
        laborPercentage: 30.0,
        materialsPercentage: 50.0,
        otherPercentage: 20.0,
      );
    }
    notifyListeners();
  }
  
  double _calculateLaborSpent() {
    // Get total paid payments from payment service
    return _paymentService.payments
        .where((payment) => payment.isPaid)
        .fold(0.0, (sum, payment) => sum + payment.amount);
  }
  
  Future<void> updateBudget({
    double? totalBudget,
    double? laborBudget,
    double? materialsBudget,
    double? otherBudget,
  }) async {
    _summary = FinancialSummary(
      totalBudget: totalBudget ?? _summary.totalBudget,
      laborBudget: laborBudget ?? _summary.laborBudget,
      materialsBudget: materialsBudget ?? _summary.materialsBudget,
      otherBudget: otherBudget ?? _summary.otherBudget,
      laborSpent: _summary.laborSpent,
      materialsSpent: _summary.materialsSpent,
      otherSpent: _summary.otherSpent,  
      totalSpent: _summary.totalSpent, 
      totalRemaining: (totalBudget ?? _summary.totalBudget) - (_summary.laborSpent + _summary.materialsSpent + _summary.otherSpent),
      percentageSpent: ((_summary.laborSpent + _summary.materialsSpent + _summary.otherSpent) / (totalBudget ?? _summary.totalBudget)) * 100,
      laborPercentage: (_summary.laborSpent / (totalBudget ?? _summary.totalBudget)) * 100,
      materialsPercentage: (_summary.materialsSpent / (totalBudget ?? _summary.totalBudget)) * 100,
      otherPercentage: (_summary.otherSpent / (totalBudget ?? _summary.totalBudget)) * 100,   
    );
    
    // Save to persistence
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('financial_summary', jsonEncode({
      'totalBudget': _summary.totalBudget,
      'laborBudget': _summary.laborBudget,
      'materialsBudget': _summary.materialsBudget,
      'otherBudget': _summary.otherBudget,
      'laborSpent': _summary.laborSpent,
      'materialsSpent': _summary.materialsSpent,
      'otherSpent': _summary.otherSpent,
    }));
    
    notifyListeners();
  }
  
  Future<void> updateExpenses({
    double? laborSpent,
    double? materialsSpent,
    double? otherSpent,
  }) async {
    _summary = FinancialSummary(
      totalBudget: _summary.totalBudget,
      laborBudget: _summary.laborBudget,
      materialsBudget: _summary.materialsBudget,
      otherBudget: _summary.otherBudget,
      laborSpent: laborSpent ?? _summary.laborSpent,
      materialsSpent: materialsSpent ?? _summary.materialsSpent,
      otherSpent: otherSpent ?? _summary.otherSpent, totalSpent: 24000000,
      totalRemaining: _summary.totalBudget - (_summary.laborSpent + _summary.materialsSpent + _summary.otherSpent),     
      percentageSpent: ((_summary.laborSpent + _summary.materialsSpent + _summary.otherSpent) / _summary.totalBudget) * 100,
      laborPercentage: (_summary.laborSpent / _summary.totalBudget) * 100,
      materialsPercentage: (_summary.materialsSpent / _summary.totalBudget) * 100,
      otherPercentage: (_summary.otherSpent / _summary.totalBudget) * 100,
    );
    
    // Save to persistence
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('financial_summary', jsonEncode({
      'totalBudget': _summary.totalBudget,
      'laborBudget': _summary.laborBudget,
      'materialsBudget': _summary.materialsBudget,
      'otherBudget': _summary.otherBudget,
      'laborSpent': _summary.laborSpent,
      'materialsSpent': _summary.materialsSpent,
      'otherSpent': _summary.otherSpent,
    }));
    
    notifyListeners();
  }
  
  // Generate monthly report data
  List<Map<String, dynamic>> generateMonthlyReport(DateTime startDate, DateTime endDate) {
    // Example implementation - replace with real data from payment records
    return [
      {'month': 'Jan', 'labor': 15000000, 'materials': 10000000, 'other': 2000000, 'total': 27000000},
      {'month': 'Feb', 'labor': 12000000, 'materials': 12000000, 'other': 1500000, 'total': 25500000},
      {'month': 'Mar', 'labor': 14000000, 'materials': 9000000, 'other': 1800000, 'total': 24800000},
      {'month': 'Apr', 'labor': 16000000, 'materials': 11000000, 'other': 2100000, 'total': 29100000},
      {'month': 'May', 'labor': 13000000, 'materials': 10500000, 'other': 1900000, 'total': 25400000},
      {'month': 'Jun', 'labor': 15000000, 'materials': 12500000, 'other': 2200000, 'total': 29700000},
    ];
  }
} 