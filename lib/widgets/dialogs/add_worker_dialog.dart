import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/worker.dart';
import '../../services/worker_service.dart';

class AddWorkerDialog extends StatefulWidget {
  final WorkerType initialType;

  const AddWorkerDialog({
    super.key,
    this.initialType = WorkerType.weeklyWage,
  });

  @override
  _AddWorkerDialogState createState() => _AddWorkerDialogState();
}

class _AddWorkerDialogState extends State<AddWorkerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _specializationController = TextEditingController();
  
  late WorkerType _selectedType;
  late String _selectedPosition;
  late PaymentFrequency _selectedFrequency;
  
  List<String> _positionOptions = [];
  
  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    _updatePositionOptions();
    _selectedPosition = _positionOptions.first;
    
    // Set default payment frequency based on worker type
    _selectedFrequency = _getDefaultFrequency(_selectedType);
  }

  PaymentFrequency _getDefaultFrequency(WorkerType type) {
    switch (type) {
      case WorkerType.weeklyWage:
        return PaymentFrequency.weekly;
      case WorkerType.professional:
        return PaymentFrequency.monthly;
      case WorkerType.salaried:
        return PaymentFrequency.monthly;
      case WorkerType.miscellaneous:
        return PaymentFrequency.oneTime;
    }
  }
  
  void _updatePositionOptions() {
    switch (_selectedType) {
      case WorkerType.weeklyWage:
        _positionOptions = ['Foreman', 'Assistant', 'Carpenter', 'Mason', 'Helper', 'Steel Fixer'];
        break;
      case WorkerType.professional:
        _positionOptions = ['Architect', 'Engineer', 'Project Manager', 'Consultant', 'Interior Designer'];
        break;
      case WorkerType.salaried:
        _positionOptions = ['Site Manager', 'Accountant', 'HR Manager', 'Administrator', 'Supervisor'];
        break;
      case WorkerType.miscellaneous:
        _positionOptions = ['Contractor', 'Vendor', 'Supplier', 'Temporary Staff', 'Other'];
        break;
    }
    
    // Reset selected position when type changes
    if (_positionOptions.isNotEmpty) {
      _selectedPosition = _positionOptions.first;
    }
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _rateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    super.dispose();
  }
  
  String _getRateLabel() {
    switch (_selectedFrequency) {
      case PaymentFrequency.weekly:
        return 'Weekly Rate';
      case PaymentFrequency.monthly:
        return 'Monthly Rate';
      case PaymentFrequency.oneTime:
        return 'Payment Amount';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    return AlertDialog(
      backgroundColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
      title: Text(
        'Add New Worker',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWorkerTypeSelector(isLightTheme, textColor),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter worker name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildPositionDropdown(isLightTheme, textColor),
                const SizedBox(height: 16),
                _buildPaymentFrequencyDropdown(isLightTheme, textColor),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _rateController,
                  label: _getRateLabel(),
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                  keyboardType: TextInputType.number,
                  prefixText: 'KES ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rate';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                if (_selectedType == WorkerType.professional) ...[
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _specializationController,
                    label: 'Specialization',
                    isLightTheme: isLightTheme,
                    textColor: textColor,
                  ),
                ],
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number (Optional)',
                  isLightTheme: isLightTheme,
                  textColor: textColor,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email (Optional)',
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
          child: Text(
            'Cancel',
            style: TextStyle(
              color: isLightTheme ? Colors.black54 : Colors.grey[400],
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
          ),
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final workerService = Provider.of<WorkerService>(context, listen: false);
              
              workerService.addWorker(
                name: _nameController.text,
                position: _selectedPosition,
                type: _selectedType,
                rate: double.parse(_rateController.text),
                paymentFrequency: _selectedFrequency,
                specialization: _selectedType == WorkerType.professional 
                    ? _specializationController.text 
                    : null,
                phoneNumber: _phoneController.text.isEmpty ? null : _phoneController.text,
                email: _emailController.text.isEmpty ? null : _emailController.text,
              );
              
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
  
  Widget _buildWorkerTypeSelector(bool isLightTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Worker Type',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<WorkerType>(
              isExpanded: true,
              value: _selectedType,
              dropdownColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
              items: WorkerType.values.map((type) {
                String label = '';
                switch (type) {
                  case WorkerType.weeklyWage:
                    label = 'Weekly Wage Worker';
                    break;
                  case WorkerType.professional:
                    label = 'Professional';
                    break;
                  case WorkerType.salaried:
                    label = 'Salaried Staff';
                    break;
                  case WorkerType.miscellaneous:
                    label = 'Miscellaneous';
                    break;
                }
                
                return DropdownMenuItem<WorkerType>(
                  value: type,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                  _updatePositionOptions();
                  _selectedFrequency = _getDefaultFrequency(_selectedType);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPositionDropdown(bool isLightTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Position',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedPosition,
              dropdownColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
              items: _positionOptions.map((position) {
                return DropdownMenuItem<String>(
                  value: position,
                  child: Text(
                    position,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPaymentFrequencyDropdown(bool isLightTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Frequency',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PaymentFrequency>(
              isExpanded: true,
              value: _selectedFrequency,
              dropdownColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
              items: PaymentFrequency.values.map((frequency) {
                String label = '';
                switch (frequency) {
                  case PaymentFrequency.weekly:
                    label = 'Weekly';
                    break;
                  case PaymentFrequency.monthly:
                    label = 'Monthly';
                    break;
                  case PaymentFrequency.oneTime:
                    label = 'One-Time Payment';
                    break;
                }
                
                return DropdownMenuItem<PaymentFrequency>(
                  value: frequency,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFrequency = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isLightTheme,
    required Color textColor,
    TextInputType? keyboardType,
    String? prefixText,
    String? Function(String?)? validator,
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
            prefixText: prefixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: TextStyle(color: textColor),
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }
} 