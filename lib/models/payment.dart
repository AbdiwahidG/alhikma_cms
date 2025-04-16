import 'worker.dart';

class Payment {
  final String id;
  final String workerId;
  final DateTime date;
  final String weekCode; // e.g. W023
  final double rate;          // Weekly or monthly rate
  final double amount;        // Total payment amount
  final bool isPaid;
  final String? notes;
  final PaymentFrequency frequency; // Weekly, Monthly, or One-time
  final int? daysWorked;      // For weekly wage workers
  final bool includesOvertime; // Whether overtime is included

  Payment({
    required this.id,
    required this.workerId,
    required this.date,
    required this.weekCode,
    required this.rate,
    required this.amount,
    required this.frequency,
    this.daysWorked,
    this.includesOvertime = false,
    this.isPaid = false,
    this.notes,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      workerId: json['workerId'],
      date: DateTime.parse(json['date']),
      weekCode: json['weekCode'],
      rate: json['rate'].toDouble(),
      amount: json['amount'].toDouble(),
      frequency: PaymentFrequency.values.firstWhere(
        (e) => e.toString() == 'PaymentFrequency.${json['frequency']}',
        orElse: () => PaymentFrequency.weekly,
      ),
      daysWorked: json['daysWorked'],
      includesOvertime: json['includesOvertime'] ?? false,
      isPaid: json['isPaid'] ?? false,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'date': date.toIso8601String(),
      'weekCode': weekCode,
      'rate': rate,
      'amount': amount,
      'frequency': frequency.toString().split('.').last,
      'daysWorked': daysWorked,
      'includesOvertime': includesOvertime,
      'isPaid': isPaid,
      'notes': notes,
    };
  }
} 