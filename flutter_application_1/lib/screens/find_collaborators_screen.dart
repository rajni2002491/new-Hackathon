import 'package:flutter/material.dart';
import 'user_profile_screen.dart';

class FindCollaboratorsScreen extends StatefulWidget {
  const FindCollaboratorsScreen({super.key});

  @override
  State<FindCollaboratorsScreen> createState() =>
      _FindCollaboratorsScreenState();
}

class _FindCollaboratorsScreenState extends State<FindCollaboratorsScreen> {
  final _searchController = TextEditingController();
  String _selectedRole = 'All';
  final List<String> _roles = ['All', 'Learner', 'Builder', 'Mentor'];
  final List<String> _selectedSkills = [];

  // Dummy data for skill suggestions
  final List<String> _skillSuggestions = [
    'Flutter',
    'React',
    'Node.js',
    'Python',
    'Java',
    'UI/UX Design',
    'Project Management',
    'Data Science',
    'Machine Learning',
    'Cloud Computing',
    'DevOps',
  ];

  // Dummy user data
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'John Doe',
      'role': 'Builder',
      'skills': ['Flutter', 'React', 'Node.js'],
      'bio': 'Full-stack developer with 5 years of experience',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'role': 'Mentor',
      'skills': ['Python', 'Data Science', 'Machine Learning'],
      'bio': 'Data scientist and ML engineer, passionate about teaching',
    },
    {
      'id': '3',
      'name': 'Mike Johnson',
      'role': 'Learner',
      'skills': ['UI/UX Design', 'React'],
      'bio': 'UI/UX designer learning frontend development',
    },
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch =
          user['name'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          user['skills'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      final matchesRole =
          _selectedRole == 'All' || user['role'] == _selectedRole;
      final matchesSkills =
          _selectedSkills.isEmpty ||
          _selectedSkills.any(
            (skill) => (user['skills'] as List<String>).contains(skill),
          );
      return matchesSearch && matchesRole && matchesSkills;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Collaborators')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name or skills...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _roles
                            .map(
                              (role) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(role),
                                  selected: _selectedRole == role,
                                  onSelected: (selected) {
                                    setState(() {
                                      _selectedRole = role;
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Filter by Skills',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _skillSuggestions.map((skill) {
                        final isSelected = _selectedSkills.contains(skill);
                        return FilterChip(
                          label: Text(skill),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedSkills.add(skill);
                              } else {
                                _selectedSkills.remove(skill);
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(user['name'][0])),
                    title: Text(user['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['role']),
                        Wrap(
                          spacing: 4,
                          children:
                              (user['skills'] as List<String>)
                                  .map(
                                    (skill) => Chip(
                                      label: Text(skill),
                                      backgroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  )
                                  .toList(),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(user: user),
                          ),
                        );
                      },
                      child: const Text('View Profile'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
