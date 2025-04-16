class WeekSummary {
  final String weekCode; // e.g. W023
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, double> positionTotals; // Position: total amount
  final double totalAmount;
  
  WeekSummary({
    required this.weekCode,
    required this.startDate,
    required this.endDate,
    required this.positionTotals,
    required this.totalAmount,
  });
  
  factory WeekSummary.fromJson(Map<String, dynamic> json) {
    return WeekSummary(
      weekCode: json['weekCode'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      positionTotals: Map<String, double>.from(json['positionTotals']),
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'weekCode': weekCode,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'positionTotals': positionTotals,
      'totalAmount': totalAmount,
    };
  }
} 