import 'package:flutter/material.dart';

class FindMentorScreen extends StatefulWidget {
  const FindMentorScreen({super.key});

  @override
  State<FindMentorScreen> createState() => _FindMentorScreenState();
}

class _FindMentorScreenState extends State<FindMentorScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Available', 'Top Rated'];
  final TextEditingController _searchController = TextEditingController();

  // Dummy mentor data
  final List<Map<String, dynamic>> _mentors = [
    {
      'id': '1',
      'name': 'Dr. Sarah Johnson',
      'title': 'Senior Software Engineer',
      'company': 'Google',
      'expertise': ['Flutter', 'Mobile Development', 'UI/UX'],
      'rating': 4.8,
      'reviews': 128,
      'availability': 'Available',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg',
      'bio':
          '10+ years of experience in mobile development. Specialized in Flutter and cross-platform solutions.',
      'hourlyRate': 75,
    },
    {
      'id': '2',
      'name': 'Prof. Michael Chen',
      'title': 'Technical Lead',
      'company': 'Microsoft',
      'expertise': ['Cloud Computing', 'AWS', 'System Design'],
      'rating': 4.9,
      'reviews': 256,
      'availability': 'Available',
      'image': 'https://randomuser.me/api/portraits/men/2.jpg',
      'bio':
          'Cloud architecture expert with 15 years of experience. Certified AWS Solutions Architect.',
      'hourlyRate': 90,
    },
    {
      'id': '3',
      'name': 'Lisa Rodriguez',
      'title': 'Senior Product Manager',
      'company': 'Amazon',
      'expertise': ['Product Strategy', 'Agile', 'User Research'],
      'rating': 4.7,
      'reviews': 95,
      'availability': 'Limited',
      'image': 'https://randomuser.me/api/portraits/women/3.jpg',
      'bio':
          'Product management expert with focus on user-centered design and agile methodologies.',
      'hourlyRate': 85,
    },
  ];

  List<Map<String, dynamic>> get _filteredMentors {
    if (_selectedFilter == 'All') return _mentors;
    if (_selectedFilter == 'Available') {
      return _mentors
          .where((mentor) => mentor['availability'] == 'Available')
          .toList();
    }
    return _mentors.where((mentor) => mentor['rating'] >= 4.8).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Mentor'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Search and Filter Row
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search mentors...',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Filter Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.filter_list,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onSelected: (value) {
                        setState(() {
                          _selectedFilter = value;
                        });
                      },
                      itemBuilder:
                          (context) =>
                              _filters
                                  .map(
                                    (filter) => PopupMenuItem<String>(
                                      value: filter,
                                      child: Row(
                                        children: [
                                          Icon(
                                            _selectedFilter == filter
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked,
                                            color:
                                                _selectedFilter == filter
                                                    ? Theme.of(
                                                      context,
                                                    ).colorScheme.primary
                                                    : Colors.grey,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(filter),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Selected Filter Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Filter: ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedFilter,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Mentors List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredMentors.length,
                itemBuilder: (context, index) {
                  final mentor = _filteredMentors[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                                backgroundImage: NetworkImage(mentor['image']),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mentor['name'],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      mentor['title'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      mentor['company'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      mentor['availability'] == 'Available'
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      mentor['availability'] == 'Available'
                                          ? Icons.check_circle
                                          : Icons.access_time,
                                      size: 16,
                                      color:
                                          mentor['availability'] == 'Available'
                                              ? Colors.green
                                              : Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      mentor['availability'],
                                      style: TextStyle(
                                        color:
                                            mentor['availability'] ==
                                                    'Available'
                                                ? Colors.green
                                                : Colors.orange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            mentor['bio'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Compact Skills Section
                          Row(
                            children: [
                              Icon(
                                Icons.psychology,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Expertise: ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  (mentor['expertise'] as List<String>).join(
                                    ', ',
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    mentor['rating'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${mentor['reviews']} reviews)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '\$${mentor['hourlyRate']}/hour',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement connect with mentor functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Connect with Mentor'),
                            ),
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
      ),
    );
  }
}
