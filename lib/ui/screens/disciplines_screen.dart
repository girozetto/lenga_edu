import 'package:flutter/material.dart';
import 'package:lenga_edu/core/models/discipline.dart';
import 'package:lenga_edu/core/models/simulation_descriptor.dart';
import 'package:lenga_edu/core/services/service_initializer.dart';
import 'package:lenga_edu/ui/widgets/disciplines/disciplines_header.dart';
import 'package:lenga_edu/ui/widgets/disciplines/disciplines_sidebar.dart';
import 'package:lenga_edu/ui/widgets/disciplines/simulation_list_item.dart';
import 'package:lenga_edu/ui/widgets/lenga_app_bar.dart';

class DisciplinesScreen extends StatefulWidget {
  final Discipline? initialDiscipline;

  const DisciplinesScreen({super.key, this.initialDiscipline});

  @override
  State<DisciplinesScreen> createState() => _DisciplinesScreenState();
}

class _DisciplinesScreenState extends State<DisciplinesScreen> {
  Discipline? _selectedDiscipline; // null represents "Todos"
  String _searchQuery = '';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _selectedDiscipline = widget.initialDiscipline;
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width to handle responsiveness
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    // Fetch Data
    final allDisciplines = ServiceInitializer.disciplineService!
        .searchDisciplines('');

    // Filter Simulations
    List<SimulationDescriptor> simulations;
    if (_selectedDiscipline == null) {
      simulations = ServiceInitializer.simulationService!.getSimulations();
    } else {
      simulations = ServiceInitializer.simulationService!
          .getSimulationsForDiscipline(_selectedDiscipline!.id);
    }

    if (_searchQuery.isNotEmpty) {
      simulations = simulations.where((s) {
        return s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply Sort
    simulations.sort((a, b) {
      final comparison = a.name.compareTo(b.name);
      return _isAscending ? comparison : -comparison;
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8), // background-light
      appBar: const LengaAppBar(title: 'LengaEdu'),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SIDEBAR (Only visible on Desktop/Tablet)
          if (isDesktop)
            DisciplinesSidebar(
              selectedDiscipline: _selectedDiscipline,
              allDisciplines: allDisciplines,
              onDisciplineSelected: (discipline) {
                setState(() => _selectedDiscipline = discipline);
              },
            ),

          // MAIN CONTENT AREA
          Expanded(
            child: Column(
              children: [
                // Header & Search
                DisciplinesHeader(
                  selectedDiscipline: _selectedDiscipline,
                  isAscending: _isAscending,
                  onSearchChanged: (val) {
                    setState(() => _searchQuery = val);
                  },
                  onSortChanged: (val) {
                    setState(() => _isAscending = val);
                  },
                ),

                // Simulations List
                Expanded(
                  child: simulations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhuma simulação encontrada.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(24),
                          itemCount: simulations.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final sim = simulations[index];
                            return SimulationListItem(simulation: sim);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Mobile Drawer for Sidebar
      drawer: !isDesktop
          ? Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xFF308CE8)),
                    child: Center(
                      child: Text(
                        'Disciplinas',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder_open),
                    title: const Text('Todos'),
                    selected: _selectedDiscipline == null,
                    onTap: () {
                      setState(() => _selectedDiscipline = null);
                      Navigator.pop(context);
                    },
                  ),
                  ...allDisciplines.map(
                    (d) => ListTile(
                      leading: Icon(d.icon),
                      title: Text(d.name),
                      selected: _selectedDiscipline?.id == d.id,
                      onTap: () {
                        setState(() => _selectedDiscipline = d);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
