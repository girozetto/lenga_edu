import 'package:flutter/material.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';
import '../widgets/discipline_card.dart';
import '../widgets/lenga_app_bar.dart';
import '../widgets/lenga_search_field.dart';
import 'discipline_simulations_screen.dart';

class DisciplinesScreen extends StatefulWidget {
  const DisciplinesScreen({super.key});

  @override
  State<DisciplinesScreen> createState() => _DisciplinesScreenState();
}

class _DisciplinesScreenState extends State<DisciplinesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final disciplines = ServiceInitializer.disciplineService!.searchDisciplines(
      _searchQuery,
    );

    return Scaffold(
      appBar: const LengaAppBar(title: 'Disciplinas'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LengaSearchField(
              hintText: 'Pesquisar disciplina...',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: disciplines.length,
              itemBuilder: (context, index) {
                return DisciplineCard(
                  discipline: disciplines[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisciplineSimulationsScreen(
                          discipline: disciplines[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
