import 'package:flutter/material.dart';
import 'mentorship_request_screen.dart';
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
      'name': 'Dr. Sarah Johnson',
      'title': 'Senior Software Engineer',
      'company': 'Tech Solutions Inc.',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/028/794/707/small_2x/cartoon-cute-school-boy-photo.jpg',
      'skills': ['Flutter', 'Mobile Development', 'UI/UX'],
      'bio':
          'Experienced software engineer with 10+ years in mobile development. Passionate about mentoring and helping others grow.',
      'availability': 'Available',
      'rating': 4.8,
      'type': 'individual',
    },
    {
      'id': '2',
      'name': 'Innovation Labs',
      'title': 'Tech Education Organization',
      'company': 'Innovation Labs Inc.',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/034/210/204/small_2x/3d-cartoon-baby-genius-photo.jpg',
      'skills': ['Web Development', 'Cloud Computing', 'AWS'],
      'bio':
          'Leading tech education organization providing mentorship and training programs. Connect with our expert mentors.',
      'availability': 'Available',
      'rating': 4.9,
      'type': 'organization',
    },
    {
      'id': '3',
      'name': 'Emily Rodriguez',
      'title': 'UX Design Director',
      'company': 'Design Studio',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/034/210/207/small/3d-cartoon-baby-genius-photo.jpg',
      'skills': ['UI/UX', 'Figma', 'Prototyping'],
      'bio':
          'Award-winning UX designer with expertise in creating intuitive and beautiful user experiences. Available for mentorship.',
      'availability': 'Available',
      'rating': 4.7,
      'type': 'individual',
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Mentor'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
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
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                mentor['image'] as String,
                              ),
                            ),
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
                                  const SizedBox(height: 4),
                                  Text(
                                    mentor['title'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    mentor['company'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
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
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          mentor['type'] == 'individual'
                                              ? 'Individual Mentor'
                                              : 'Organization',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => MentorshipRequestScreen(
                                          mentor: mentor,
                                        ),
                                  ),
                                );
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
