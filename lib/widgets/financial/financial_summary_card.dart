import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/financial_summary.dart';

class FinancialSummaryCard extends StatelessWidget {
  final FinancialSummary summary;
  
  const FinancialSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROJECT FINANCIAL SUMMARY',
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Al-Hikma Residency',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(summary.percentageSpent).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(summary.percentageSpent),
                  style: TextStyle(
                    color: _getStatusColor(summary.percentageSpent),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Summary metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Budget',
                  _formatAmount(summary.totalBudget),
                  'KES',
                  Colors.blue,
                  textColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Total Spent',
                  _formatAmount(summary.totalSpent),
                  '${summary.percentageSpent.toStringAsFixed(1)}%',
                  Colors.orange,
                  textColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Remaining Budget',
                  _formatAmount(summary.totalRemaining),
                  'KES',
                  Colors.green,
                  textColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Days to Deadline',
                  '45',
                  'days',
                  AppTheme.primaryColor,
                  textColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Budget breakdown
          Text(
            'BUDGET BREAKDOWN',
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          
          // Labor row
          _buildCategoryRow(
            'Labor',
            summary.laborBudget,
            summary.laborSpent,
            summary.laborPercentage,
            Colors.blue,
            textColor,
          ),
          const SizedBox(height: 16),
          
          // Materials row
          _buildCategoryRow(
            'Materials',
            summary.materialsBudget,
            summary.materialsSpent,
            summary.materialsPercentage,
            Colors.green,
            textColor,
          ),
          const SizedBox(height: 16),
          
          // Other row
          _buildCategoryRow(
            'Other Expenses',
            summary.otherBudget,
            summary.otherSpent,
            summary.otherPercentage,
            Colors.orange,
            textColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    Color color,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryRow(
    String category,
    double budget,
    double spent,
    double percentage,
    Color color,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Budget: KES ${_formatAmount(budget)}',
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            Text(
              'Spent: KES ${_formatAmount(spent)}',
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            Text(
              'Remaining: KES ${_formatAmount(budget - spent)}',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
  
  Color _getStatusColor(double percentage) {
    if (percentage < 80) {
      return Colors.green;
    } else if (percentage < 95) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  String _getStatusText(double percentage) {
    if (percentage < 80) {
      return 'On Track';
    } else if (percentage < 95) {
      return 'Warning';
    } else {
      return 'Over Budget';
    }
  }
} 