import 'package:flutter/material.dart';

class Task {
  final String id;
  final String name;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String assignedTo;
  final Color categoryColor;
  final bool isMilestone;

  Task({
    required this.id,
    required this.name,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.assignedTo,
    required this.categoryColor,
    this.isMilestone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String,
      assignedTo: json['assignedTo'] as String,
      categoryColor: Color(json['categoryColor'] as int),
      isMilestone: json['isMilestone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'assignedTo': assignedTo,
      'categoryColor': categoryColor.value,
      'isMilestone': isMilestone,
    };
  }

  Task copyWith({
    String? id,
    String? name,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? assignedTo,
    Color? categoryColor,
    bool? isMilestone,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      categoryColor: categoryColor ?? this.categoryColor,
      isMilestone: isMilestone ?? this.isMilestone,
    );
  }
} 