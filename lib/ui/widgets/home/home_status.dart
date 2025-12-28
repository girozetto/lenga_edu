import 'package:flutter/material.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';

class HomeStatus extends StatelessWidget {
  const HomeStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi_off, size: 18, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Modo Offline',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Versão ${ServiceInitializer.repo?.appVersion ?? '1.24.0 LT'}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}
