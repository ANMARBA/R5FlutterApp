import 'package:flutter/material.dart';

class ErrorManagement extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorManagement({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ocurrió un error. Por favor, inténtelo de nuevo.',
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
