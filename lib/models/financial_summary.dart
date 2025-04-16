class FinancialSummary {
  final double totalBudget;
  final double totalSpent;
  final double totalRemaining;
  final double percentageSpent;
  
  // Labor costs
  final double laborBudget;
  final double laborSpent;
  final double laborPercentage;
  
  // Materials costs
  final double materialsBudget;
  final double materialsSpent;
  final double materialsPercentage;
  
  // Other expenses
  final double otherBudget;
  final double otherSpent;
  final double otherPercentage;
  
  FinancialSummary({
    required this.totalBudget,
    required this.totalSpent,
    required this.totalRemaining,
    required this.percentageSpent,
    required this.laborBudget,
    required this.laborSpent,
    required this.laborPercentage,
    required this.materialsBudget,
    required this.materialsSpent,
    required this.materialsPercentage,
    required this.otherBudget,
    required this.otherSpent,
    required this.otherPercentage,
  });
  
  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      totalBudget: json['totalBudget']?.toDouble() ?? 0.0,
      totalSpent: json['totalSpent']?.toDouble() ?? 0.0,
      totalRemaining: json['totalRemaining']?.toDouble() ?? 0.0,
      percentageSpent: json['percentageSpent']?.toDouble() ?? 0.0,
      laborBudget: json['laborBudget']?.toDouble() ?? 0.0,
      laborSpent: json['laborSpent']?.toDouble() ?? 0.0,
      laborPercentage: json['laborPercentage']?.toDouble() ?? 0.0,
      materialsBudget: json['materialsBudget']?.toDouble() ?? 0.0,
      materialsSpent: json['materialsSpent']?.toDouble() ?? 0.0,
      materialsPercentage: json['materialsPercentage']?.toDouble() ?? 0.0,
      otherBudget: json['otherBudget']?.toDouble() ?? 0.0,
      otherSpent: json['otherSpent']?.toDouble() ?? 0.0,
      otherPercentage: json['otherPercentage']?.toDouble() ?? 0.0,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalBudget': totalBudget,
      'totalSpent': totalSpent,
      'totalRemaining': totalRemaining,
      'percentageSpent': percentageSpent,
      'laborBudget': laborBudget,
      'laborSpent': laborSpent,
      'laborPercentage': laborPercentage,
      'materialsBudget': materialsBudget,
      'materialsSpent': materialsSpent,
      'materialsPercentage': materialsPercentage,
      'otherBudget': otherBudget,
      'otherSpent': otherSpent,
      'otherPercentage': otherPercentage,
    };
  }
  
  FinancialSummary copyWith({
    double? totalBudget,
    double? totalSpent,
    double? totalRemaining,
    double? percentageSpent,
    double? laborBudget,
    double? laborSpent,
    double? laborPercentage,
    double? materialsBudget,
    double? materialsSpent,
    double? materialsPercentage,
    double? otherBudget,
    double? otherSpent,
    double? otherPercentage,
  }) {
    return FinancialSummary(
      totalBudget: totalBudget ?? this.totalBudget,
      totalSpent: totalSpent ?? this.totalSpent,
      totalRemaining: totalRemaining ?? this.totalRemaining,
      percentageSpent: percentageSpent ?? this.percentageSpent,
      laborBudget: laborBudget ?? this.laborBudget,
      laborSpent: laborSpent ?? this.laborSpent,
      laborPercentage: laborPercentage ?? this.laborPercentage,
      materialsBudget: materialsBudget ?? this.materialsBudget,
      materialsSpent: materialsSpent ?? this.materialsSpent,
      materialsPercentage: materialsPercentage ?? this.materialsPercentage,
      otherBudget: otherBudget ?? this.otherBudget,
      otherSpent: otherSpent ?? this.otherSpent,
      otherPercentage: otherPercentage ?? this.otherPercentage,
    );
  }
} 