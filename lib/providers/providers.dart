import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/worker_service.dart';
import '../services/payment_service.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkerService()),
        ChangeNotifierProxyProvider<WorkerService, PaymentService>(
          create: (_) => PaymentService(),
          update: (_, workerService, paymentService) => paymentService ?? PaymentService(),
        ),
      ],
      child: child,
    );
  }
} 