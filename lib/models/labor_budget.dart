class LaborBudget {
  final double totalBudget;
  final double usedBudget;
  double get remainingBudget => totalBudget - usedBudget;
  double get percentageUsed => (usedBudget / totalBudget) * 100;
  
  LaborBudget({
    required this.totalBudget,
    required this.usedBudget,
  });
  
  factory LaborBudget.fromJson(Map<String, dynamic> json) {
    return LaborBudget(
      totalBudget: json['totalBudget'].toDouble(),
      usedBudget: json['usedBudget'].toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalBudget': totalBudget,
      'usedBudget': usedBudget,
    };
  }
} 