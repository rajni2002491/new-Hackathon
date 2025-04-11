import 'package:flutter/material.dart';
import 'user_profile_screen.dart';

class MentorConnectScreen extends StatefulWidget {
  const MentorConnectScreen({super.key});

  @override
  State<MentorConnectScreen> createState() => _MentorConnectScreenState();
}

class _MentorConnectScreenState extends State<MentorConnectScreen> {
  final _searchController = TextEditingController();
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

  // Dummy mentor data
  final List<Map<String, dynamic>> _mentors = [
    {
      'id': '1',
      'name': 'Jane Smith',
      'role': 'Mentor',
      'skills': ['Python', 'Data Science', 'Machine Learning'],
      'bio':
          'Data scientist and ML engineer with 10 years of experience. Passionate about teaching and mentoring.',
      'availability': 'Weekdays, 6 PM - 9 PM',
      'rating': 4.8,
    },
    {
      'id': '2',
      'name': 'Mike Johnson',
      'role': 'Mentor',
      'skills': ['UI/UX Design', 'React', 'Project Management'],
      'bio':
          'Senior UI/UX designer and frontend developer. Love helping others grow in their design journey.',
      'availability': 'Weekends, 10 AM - 4 PM',
      'rating': 4.9,
    },
  ];

  List<Map<String, dynamic>> get _filteredMentors {
    return _mentors.where((mentor) {
      final matchesSearch =
          mentor['name'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          mentor['skills'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      final matchesSkills =
          _selectedSkills.isEmpty ||
          _selectedSkills.any(
            (skill) => (mentor['skills'] as List<String>).contains(skill),
          );
      return matchesSearch && matchesSkills;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find a Mentor')),
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
              itemCount: _filteredMentors.length,
              itemBuilder: (context, index) {
                final mentor = _filteredMentors[index];
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
                          children: [
                            CircleAvatar(child: Text(mentor['name'][0])),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mentor['name'],
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        mentor['rating'].toString(),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(mentor['bio']),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              (mentor['skills'] as List<String>)
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
                          children: [
                            const Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'Available: ${mentor['availability']}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            UserProfileScreen(user: mentor),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.person),
                              label: const Text('View Profile'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Implement mentorship request
                              },
                              icon: const Icon(Icons.school),
                              label: const Text('Request Mentorship'),
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
    );
  }
}
