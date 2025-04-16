import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../services/financial_service.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _selectedReportType = 'Financial Summary';
  bool _includeLabor = true;
  bool _includeMaterials = true;
  bool _includeOther = true;

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    return AlertDialog(
      title: Text(
        'Generate Financial Report',
        style: TextStyle(color: textColor),
      ),
      backgroundColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateRangePicker(
                  label: 'Date Range',
                  startDate: _startDate,
                  endDate: _endDate,
                  onStartDateChanged: (date) => setState(() => _startDate = date),
                  onEndDateChanged: (date) => setState(() => _endDate = date),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildReportTypeDropdown(
                  value: _selectedReportType,
                  onChanged: (value) => setState(() => _selectedReportType = value!),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Include in Report',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildCheckbox(
                  value: _includeLabor,
                  label: 'Labor Expenses',
                  onChanged: (value) => setState(() => _includeLabor = value!),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                _buildCheckbox(
                  value: _includeMaterials,
                  label: 'Materials Expenses',
                  onChanged: (value) => setState(() => _includeMaterials = value!),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                _buildCheckbox(
                  value: _includeOther,
                  label: 'Other Expenses',
                  onChanged: (value) => setState(() => _includeOther = value!),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: textColor.withOpacity(0.7)),
          ),
        ),
        ElevatedButton(
          onPressed: _generateReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
          ),
          child: const Text('Generate Report'),
        ),
      ],
    );
  }
  
  Widget _buildDateRangePicker({
    required String label,
    required DateTime startDate,
    required DateTime endDate,
    required Function(DateTime) onStartDateChanged,
    required Function(DateTime) onEndDateChanged,
    required bool isLightTheme,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    onStartDateChanged(date);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${startDate.day}/${startDate.month}/${startDate.year}',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('to'),
            const SizedBox(width: 8),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    onEndDateChanged(date);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${endDate.day}/${endDate.month}/${endDate.year}',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildReportTypeDropdown({
    required String value,
    required Function(String?) onChanged,
    required bool isLightTheme,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report Type',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
              style: TextStyle(color: textColor),
              items: const [
                DropdownMenuItem(
                  value: 'Financial Summary',
                  child: Text('Financial Summary'),
                ),
                DropdownMenuItem(
                  value: 'Cash Flow Statement',
                  child: Text('Cash Flow Statement'),
                ),
                DropdownMenuItem(
                  value: 'Profit & Loss',
                  child: Text('Profit & Loss'),
                ),
                DropdownMenuItem(
                  value: 'Budget Analysis',
                  child: Text('Budget Analysis'),
                ),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCheckbox({
    required bool value,
    required String label,
    required Function(bool?) onChanged,
    required bool isLightTheme,
    required Color textColor,
  }) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        label,
        style: TextStyle(color: textColor),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
  
  void _generateReport() {
    if (_formKey.currentState!.validate()) {
      Provider.of<FinancialService>(context, listen: false);
      
      // Generate report
      // financialService.generateMonthlyReport(
      //   startDate: _startDate,
      //   endDate: _endDate,
      //   reportType: _selectedReportType,
      //   includeLabor: _includeLabor,
      //   includeMaterials: _includeMaterials,
      //   includeOther: _includeOther,
      // );
      
      Navigator.of(context).pop();
    }
  }
} 