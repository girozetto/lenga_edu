import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/discipline.dart';

class DisciplinesHeader extends StatelessWidget {
  final Discipline? selectedDiscipline;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<bool> onSortChanged;
  final bool isAscending;

  const DisciplinesHeader({
    super.key,
    required this.selectedDiscipline,
    required this.onSearchChanged,
    required this.onSortChanged,
    this.isAscending = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F8),
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumbs (Simplified)
          Row(
            children: [
              Text(
                'Disciplinas',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                '/',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                selectedDiscipline?.name ?? 'Todos',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title & Search Row
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 24,
            runSpacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedDiscipline != null
                        ? 'Simulações de ${selectedDiscipline!.name}'
                        : 'Todas as Simulações',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Visualize e inicie simulações interativas para suas aulas.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 280,
                    child: TextField(
                      onChanged: onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Buscar simulação...',
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF308CE8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isAscending ? Icons.sort_by_alpha : Icons.sort,
                        color: const Color(0xFF334155),
                      ),
                      tooltip: isAscending
                          ? 'Ordem Crescente'
                          : 'Ordem Decrescente',
                      onPressed: () {
                        onSortChanged(!isAscending);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
