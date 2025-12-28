import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/discipline.dart';

class DisciplinesSidebar extends StatelessWidget {
  final Discipline? selectedDiscipline;
  final List<Discipline> allDisciplines;
  final ValueChanged<Discipline?> onDisciplineSelected;

  const DisciplinesSidebar({
    super.key,
    required this.selectedDiscipline,
    required this.allDisciplines,
    required this.onDisciplineSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Disciplinas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A), // slate-900
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B), // slate-500
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSidebarItem(
                  title: 'Todos',
                  icon: Icons.folder_open,
                  isSelected: selectedDiscipline == null,
                  onTap: () => onDisciplineSelected(null),
                ),
                ...allDisciplines.map((discipline) {
                  return _buildSidebarItem(
                    title: discipline.name,
                    icon: discipline.icon,
                    isSelected: selectedDiscipline?.id == discipline.id,
                    onTap: () => onDisciplineSelected(discipline),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: isSelected
            ? const Color(0xFF308CE8).withAlpha(40)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: Colors.grey[100],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF308CE8).withAlpha(51),
                    ),
                  )
                : null,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? const Color(0xFF308CE8)
                      : const Color(0xFF64748B),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF308CE8)
                        : const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
