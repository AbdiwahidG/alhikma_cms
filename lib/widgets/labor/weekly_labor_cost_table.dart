import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../services/payment_service.dart';

class WeeklyLaborCostTable extends StatelessWidget {
  const WeeklyLaborCostTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final paymentService = Provider.of<PaymentService>(context);
    
    // Get last 3 week codes
    final weekCodes = paymentService.getUniqueWeekCodes().take(3).toList();
    
    // If no week codes found, add some sample data
    if (weekCodes.isEmpty) {
      weekCodes.addAll(['W023', 'W022', 'W021']);
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(
          isLightTheme ? Colors.grey[100] : const Color(0xFF252525),
        ),
        columns: [
          'Week #',
          'Date',
          'Foreman',
          'Assistant',
          'Carpenter',
          'Mason',
          'Helper',
          'Steel Fixer',
          'Total',
        ].map((header) => DataColumn(
          label: Text(
            header,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )).toList(),
        rows: weekCodes.map((weekCode) {
          // Get payments for this week
          final weekPayments = paymentService.getPaymentsForWeek(weekCode);
          
          // Get total amount for this week
          final totalAmount = weekPayments.fold(0.0, (sum, payment) => sum + payment.amount);
          
          // Sample data for now, in real implementation you would calculate these from the payments
          final Map<String, double> positionAmounts = {
            'Foreman': 18000,
            'Assistant': 18000,
            'Carpenter': 48000,
            'Mason': 36000,
            'Helper': weekCode == 'W023' ? 48000 : 11000,
            'Steel Fixer': weekCode == 'W023' ? 47600 : 18000,
          };
          
          return DataRow(
            cells: [
              DataCell(Text(weekCode, style: TextStyle(color: textColor))),
              DataCell(Text(
                weekPayments.isNotEmpty 
                  ? DateFormat('dd MMM yyyy').format(weekPayments.first.date)
                  : weekCode == 'W023' 
                    ? '29 Dec 2022' 
                    : weekCode == 'W022' 
                      ? '24 Dec 2022' 
                      : '12 Dec 2022',
                style: TextStyle(color: textColor),
              )),
              ...positionAmounts.entries.map((entry) => 
                DataCell(Text(
                  entry.value.toStringAsFixed(0),
                  style: TextStyle(color: textColor),
                )),
              ),
              DataCell(Text(
                totalAmount > 0 ? totalAmount.toStringAsFixed(0) : '215,600',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
} 