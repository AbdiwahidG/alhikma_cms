import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CircularProgressWidget extends StatelessWidget {
  final double percentage;
  final double totalBudget;
  final double usedBudget;
  final double remainingBudget;
  final String title;
  final Color progressColor;
  final String? changePercentage;

  const CircularProgressWidget({
    super.key,
    required this.percentage,
    required this.totalBudget,
    required this.usedBudget,
    required this.remainingBudget,
    required this.title,
    required this.progressColor,
    this.changePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final formatter = NumberFormat.currency(symbol: 'KES ');

    return Card(
      elevation: 0,
      color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[100] : Colors.grey[900],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                        strokeWidth: 10,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (changePercentage != null)
                              Text(
                                changePercentage!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: changePercentage!.startsWith('+')
                                      ? Colors.green[400]
                                      : Colors.red[400],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBudgetRow(
                        'Total Budget',
                        formatter.format(totalBudget),
                        isDarkMode,
                      ),
                      const SizedBox(height: 12),
                      _buildBudgetRow(
                        'Used',
                        formatter.format(usedBudget),
                        isDarkMode,
                        textColor: progressColor,
                      ),
                      const SizedBox(height: 12),
                      _buildBudgetRow(
                        'Remaining',
                        formatter.format(remainingBudget),
                        isDarkMode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetRow(String label, String value, bool isDarkMode, {Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor ?? (isDarkMode ? Colors.grey[100] : Colors.grey[900]),
          ),
        ),
      ],
    );
  }
} 