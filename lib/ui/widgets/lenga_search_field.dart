import 'package:flutter/material.dart';

class LengaSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const LengaSearchField({
    super.key,
    this.hintText = 'Buscar...',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
      ),
      onChanged: onChanged,
    );
  }
}
