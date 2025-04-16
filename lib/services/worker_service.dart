import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/worker.dart';
import 'package:flutter/foundation.dart';

class WorkerService extends ChangeNotifier {
  final List<Worker> _workers = [];
  final String _storageKey = 'workers_data';
  bool _isLoading = false;
  
  List<Worker> get workers => _workers;
  bool get isLoading => _isLoading;
  
  // Sample data for testing
  WorkerService() {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _workers.addAll([
      Worker(
        id: '1',
        name: 'John Smith',
        position: 'Foreman',
        type: WorkerType.weeklyWage,
        rate: 800,
        paymentFrequency: PaymentFrequency.weekly,
        startDate: DateTime(2023, 1, 15),
        isActive: true,
      ),
      Worker(
        id: '2',
        name: 'Sarah Johnson',
        position: 'Architect',
        type: WorkerType.professional,
        rate: 75,
        paymentFrequency: PaymentFrequency.monthly,
        startDate: DateTime(2023, 2, 1),
        isActive: true,
      ),
      Worker(
        id: '3',
        name: 'Mike Wilson',
        position: 'Carpenter',
        type: WorkerType.weeklyWage,
        rate: 600,
        paymentFrequency: PaymentFrequency.weekly,
        startDate: DateTime(2023, 3, 10),
        isActive: true,
      ),
      Worker(
        id: '4',
        name: 'Emily Brown',
        position: 'Project Manager',
        type: WorkerType.salaried,
        rate: 5000,
        paymentFrequency: PaymentFrequency.monthly,
        startDate: DateTime(2023, 1, 1),
        isActive: true,
      ),
      Worker(
        id: '5',
        name: 'David Lee',
        position: 'Consultant',
        type: WorkerType.professional,
        rate: 90,
        paymentFrequency: PaymentFrequency.monthly,
        startDate: DateTime(2023, 4, 1),
        isActive: false,
      ),
    ]);
  }
  
  // Get workers by type
  List<Worker> getWorkersByType(WorkerType type) {
    return _workers.where((worker) => worker.type == type).toList();
  }
  
  // Initialize service
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await loadWorkers();
    } catch (e) {
      debugPrint('Error initializing worker service: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Load workers from storage
  Future<void> loadWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    final workersJson = prefs.getString(_storageKey);
    
    if (workersJson != null) {
      final List<dynamic> decodedJson = jsonDecode(workersJson);
      _workers.addAll(decodedJson.map((item) => Worker.fromJson(item)));
      notifyListeners();
    }
  }
  
  // Save workers to storage
  Future<void> saveWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    final workersJson = jsonEncode(_workers.map((worker) => worker.toJson()).toList());
    await prefs.setString(_storageKey, workersJson);
  }
  
  // Add a new worker
  Future<Worker> addWorker({
    required String name,
    required String position,
    required WorkerType type,
    required double rate,
    required PaymentFrequency paymentFrequency,
    String? specialization,
    String? phoneNumber,
    String? email,
  }) async {
    final worker = Worker(
      id: const Uuid().v4(),
      name: name,
      position: position,
      type: type,
      rate: rate,
      paymentFrequency: paymentFrequency,
      specialization: specialization,
      startDate: DateTime.now(),
      phoneNumber: phoneNumber,
      email: email,
      isActive: true,
    );
    
    _workers.add(worker);
    await saveWorkers();
    notifyListeners();
    return worker;
  }
  
  // Update an existing worker
  Future<void> updateWorker(Worker worker) async {
    final index = _workers.indexWhere((w) => w.id == worker.id);
    if (index != -1) {
      _workers[index] = worker;
      await saveWorkers();
      notifyListeners();
    }
  }
  
  // Delete a worker
  Future<void> deleteWorker(String workerId) async {
    _workers.removeWhere((worker) => worker.id == workerId);
    await saveWorkers();
    notifyListeners();
  }
  
  // Toggle worker active status
  Future<void> toggleWorkerStatus(String workerId) async {
    final index = _workers.indexWhere((w) => w.id == workerId);
    if (index != -1) {
      final worker = _workers[index];
      _workers[index] = worker.copyWith(isActive: !worker.isActive);
      await saveWorkers();
      notifyListeners();
    }
  }

  double getTotalPayroll() {
    return _workers.fold(0, (sum, worker) {
      if (!worker.isActive) return sum;
      
      switch (worker.paymentFrequency) {
        case PaymentFrequency.weekly:
          return sum + (worker.rate * 4); // Assuming 4 weeks per month
        case PaymentFrequency.monthly:
          return sum + worker.rate;
        case PaymentFrequency.oneTime:
          return sum; // One-time payments not included in monthly payroll
      }
    });
  }
} 