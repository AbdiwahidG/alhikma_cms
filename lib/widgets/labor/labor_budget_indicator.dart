import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../services/payment_service.dart';

class LaborBudgetIndicator extends StatelessWidget {
  const LaborBudgetIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final paymentService = Provider.of<PaymentService>(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: paymentService.budget.percentageUsed / 100,
                  backgroundColor: isLightTheme ? Colors.grey[300] : Colors.grey[800],
                  color: Colors.purple,
                  strokeWidth: 15,
                ),
              ),
              Column(
                children: [
                  Text(
                    '${paymentService.budget.percentageUsed.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '+10%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'The labor budget, the money used and the \nremaining amount',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBudgetItem(
                'Budget',
                '${(paymentService.budget.totalBudget / 1000000).toStringAsFixed(0)}M',
                Colors.blue,
                isLightTheme,
                textColor,
              ),
              _buildBudgetItem(
                'Used',
                '${(paymentService.budget.usedBudget / 1000000).toStringAsFixed(0)}M',
                Colors.purple,
                isLightTheme,
                textColor,
              ),
              _buildBudgetItem(
                'Remaining',
                '${(paymentService.budget.remainingBudget / 1000000).toStringAsFixed(0)}M',
                Colors.green,
                isLightTheme,
                textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildBudgetItem(String label, String value, Color color, bool isLightTheme, Color textColor) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 