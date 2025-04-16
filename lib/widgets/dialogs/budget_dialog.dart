import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../services/financial_service.dart';

class BudgetDialog extends StatefulWidget {
  const BudgetDialog({super.key});

  @override
  _BudgetDialogState createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
  final _totalBudgetController = TextEditingController();
  final _laborBudgetController = TextEditingController();
  final _materialsBudgetController = TextEditingController();
  final _otherBudgetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    final financialService = Provider.of<FinancialService>(context, listen: false);
    final summary = financialService.summary;
    
    _totalBudgetController.text = summary.totalBudget.toString();
    _laborBudgetController.text = summary.laborBudget.toString();
    _materialsBudgetController.text = summary.materialsBudget.toString();
    _otherBudgetController.text = summary.otherBudget.toString();
  }
  
  @override
  void dispose() {
    _totalBudgetController.dispose();
    _laborBudgetController.dispose();
    _materialsBudgetController.dispose();
    _otherBudgetController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    return AlertDialog(
      title: Text(
        'Adjust Budget Allocation',
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
              children: [
                _buildTextField(
                  controller: _totalBudgetController,
                  label: 'Total Budget',
                  prefix: 'KES ',
                  validator: _validateAmount,
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _laborBudgetController,
                  label: 'Labor Budget',
                  prefix: 'KES ',
                  validator: _validateAmount,
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _materialsBudgetController,
                  label: 'Materials Budget',
                  prefix: 'KES ',
                  validator: _validateAmount,
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _otherBudgetController,
                  label: 'Other Budget',
                  prefix: 'KES ',
                  validator: _validateAmount,
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
          onPressed: _saveBudget,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
          ),
          child: const Text('Save Budget'),
        ),
      ],
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String prefix,
    required String? Function(String?) validator,
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
            prefixText: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: TextStyle(color: textColor),
          keyboardType: TextInputType.number,
          validator: validator,
        ),
      ],
    );
  }
  
  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }
  
  void _saveBudget() {
    if (_formKey.currentState!.validate()) {
      final financialService = Provider.of<FinancialService>(context, listen: false);
      
      // Update budgets
      financialService.updateBudget(
        totalBudget: double.parse(_totalBudgetController.text),
        laborBudget: double.parse(_laborBudgetController.text),
        materialsBudget: double.parse(_materialsBudgetController.text),
        otherBudget: double.parse(_otherBudgetController.text),
      );
      
      Navigator.of(context).pop();
    }
  }
} 