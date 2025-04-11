import 'package:flutter/material.dart';
import 'create_project_screen.dart';

class ProjectBoardScreen extends StatefulWidget {
  const ProjectBoardScreen({super.key});

  @override
  State<ProjectBoardScreen> createState() => _ProjectBoardScreenState();
}

class _ProjectBoardScreenState extends State<ProjectBoardScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'My Projects', 'Open Projects'];

  // Dummy project data
  final List<Map<String, dynamic>> _projects = [
    {
      'id': '1',
      'title': 'E-commerce Platform',
      'description': 'A full-stack e-commerce platform with React and Node.js',
      'skills': ['React', 'Node.js', 'MongoDB'],
      'owner': 'John Doe',
      'team': ['John Doe', 'Jane Smith'],
      'isPublic': true,
    },
    {
      'id': '2',
      'title': 'Mobile Learning App',
      'description': 'Educational app for language learning',
      'skills': ['Flutter', 'Firebase', 'UI/UX Design'],
      'owner': 'Jane Smith',
      'team': ['Jane Smith', 'Mike Johnson'],
      'isPublic': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedFilter == 'All') return _projects;
    if (_selectedFilter == 'My Projects') {
      return _projects
          .where((project) => project['owner'] == 'John Doe')
          .toList();
    }
    return _projects.where((project) => project['isPublic']).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Board')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _filters
                        .map(
                          (filter) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(filter),
                              selected: _selectedFilter == filter,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = filter;
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                final project = _filteredProjects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                project['title'],
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Icon(
                              project['isPublic'] ? Icons.public : Icons.lock,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(project['description']),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              (project['skills'] as List<String>)
                                  .map(
                                    (skill) => Chip(
                                      label: Text(skill),
                                      backgroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Team: ${(project['team'] as List<String>).join(", ")}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement join project functionality
                              },
                              child: const Text('Join Project'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateProjectScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
