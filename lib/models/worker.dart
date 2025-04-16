enum WorkerType {
  weeklyWage,
  professional,
  salaried,
  miscellaneous,
}

enum PaymentFrequency {
  weekly,
  monthly,
  oneTime,
}

class Worker {
  final String id;
  final String name;
  final String position;
  final WorkerType type;
  final double rate;
  final PaymentFrequency paymentFrequency;
  final DateTime startDate;
  final bool isActive;
  final int? hoursPerWeek;

  Worker({
    required this.id,
    required this.name,
    required this.position,
    required this.type,
    required this.rate,
    required this.paymentFrequency,
    required this.startDate,
    required this.isActive,
    this.hoursPerWeek, String? specialization, String? phoneNumber, String? email,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      type: WorkerType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => WorkerType.miscellaneous,
      ),
      rate: json['rate'] as double,
      paymentFrequency: PaymentFrequency.values.firstWhere(
        (e) => e.toString() == json['paymentFrequency'],
        orElse: () => PaymentFrequency.monthly,
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      isActive: json['isActive'] as bool,
      hoursPerWeek: json['hoursPerWeek'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'type': type.toString(),
      'rate': rate,
      'paymentFrequency': paymentFrequency.toString(),
      'startDate': startDate.toIso8601String(),
      'isActive': isActive,
      'hoursPerWeek': hoursPerWeek,
    };
  }

  Worker copyWith({
    String? id,
    String? name,
    String? position,
    WorkerType? type,
    double? rate,
    PaymentFrequency? paymentFrequency,
    DateTime? startDate,
    bool? isActive,
    int? hoursPerWeek,
  }) {
    return Worker(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      type: type ?? this.type,
      rate: rate ?? this.rate,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      hoursPerWeek: hoursPerWeek ?? this.hoursPerWeek,
    );
  }
} 