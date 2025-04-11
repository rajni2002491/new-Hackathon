import 'package:flutter/material.dart';
import 'collaboration_request_screen.dart';

class FindCollaboratorsScreen extends StatefulWidget {
  const FindCollaboratorsScreen({super.key});

  @override
  State<FindCollaboratorsScreen> createState() =>
      _FindCollaboratorsScreenState();
}

class _FindCollaboratorsScreenState extends State<FindCollaboratorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Developers',
    'Designers',
    'Writers',
    'Researchers',
  ];
  bool _isSearching = false;
  bool _isLoading = false;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _collaborators = [
    {
      'name': 'Alex Johnson',
      'role': 'UI/UX Designer',
      'skills': ['Figma', 'Adobe XD', 'Prototyping'],
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCVBqlCNAFeBULYf1VWmLr5oQMLqgaZz7aXg&s',
      'availability': 'Available',
      'rating': 4.8,
    },
    {
      'name': 'Sarah Williams',
      'role': 'Flutter Developer',
      'skills': ['Flutter', 'Dart', 'Firebase'],
      'image': 'https://randomuser.me/api/portraits/women/44.jpg',
      'availability': 'Busy',
      'rating': 4.9,
    },
    {
      'name': 'Michael Chen',
      'role': 'Backend Developer',
      'skills': ['Node.js', 'Python', 'AWS'],
      'image': 'https://randomuser.me/api/portraits/men/67.jpg',
      'availability': 'Available',
      'rating': 4.7,
    },
    {
      'name': 'Emily Rodriguez',
      'role': 'Content Writer',
      'skills': ['Copywriting', 'SEO', 'Blogging'],
      'image': 'https://randomuser.me/api/portraits/women/33.jpg',
      'availability': 'Available',
      'rating': 4.6,
    },
    {
      'name': 'David Kim',
      'role': 'Data Scientist',
      'skills': ['Python', 'Machine Learning', 'Data Analysis'],
      'image': 'https://randomuser.me/api/portraits/men/45.jpg',
      'availability': 'Busy',
      'rating': 4.9,
    },
    {
      'name': 'Lisa Patel',
      'role': 'Mobile Developer',
      'skills': ['React Native', 'JavaScript', 'iOS'],
      'image': 'https://randomuser.me/api/portraits/women/68.jpg',
      'availability': 'Available',
      'rating': 4.8,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleConnect(Map<String, dynamic> collaborator) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CollaborationRequestScreen(collaborator: collaborator),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCollaborators() {
    return _collaborators.where((collaborator) {
      // Apply search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final name = collaborator['name'].toString().toLowerCase();
        final role = collaborator['role'].toString().toLowerCase();
        final skills = (collaborator['skills'] as List<String>)
            .map((skill) => skill.toLowerCase())
            .join(' ');

        if (!name.contains(query) &&
            !role.contains(query) &&
            !skills.contains(query)) {
          return false;
        }
      }

      // Apply category filter
      if (_selectedFilter != 'All') {
        if (_selectedFilter == 'Developers' &&
            !collaborator['role'].toString().toLowerCase().contains(
              'developer',
            )) {
          return false;
        }
        if (_selectedFilter == 'Designers' &&
            !collaborator['role'].toString().toLowerCase().contains(
              'designer',
            )) {
          return false;
        }
        if (_selectedFilter == 'Writers' &&
            !collaborator['role'].toString().toLowerCase().contains('writer')) {
          return false;
        }
        if (_selectedFilter == 'Researchers' &&
            !collaborator['role'].toString().toLowerCase().contains(
              'researcher',
            )) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCollaborators = _getFilteredCollaborators();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Collaborators',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement advanced filters
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name, skills, or role...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _isSearching
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _isSearching = false;
                                    _searchQuery = '';
                                  });
                                },
                              )
                              : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isSearching = value.isNotEmpty;
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = filter == _selectedFilter;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Theme.of(context).colorScheme.primary,
                          checkmarkColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color:
                                  isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Search Results Count
          if (_searchQuery.isNotEmpty || _selectedFilter != 'All')
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Text(
                    '${filteredCollaborators.length} results found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _isSearching = false;
                        _searchQuery = '';
                        _selectedFilter = 'All';
                      });
                    },
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('Clear filters'),
                  ),
                ],
              ),
            ),

          // Collaborators List
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredCollaborators.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No collaborators found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredCollaborators.length,
                      itemBuilder: (context, index) {
                        final collaborator = filteredCollaborators[index];
                        final isAvailable =
                            collaborator['availability'] == 'Available';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Collaborator Info
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile Image
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            collaborator['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Name and Role
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  collaborator['name'],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      isAvailable
                                                          ? Colors.green
                                                              .withOpacity(0.1)
                                                          : Colors.orange
                                                              .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  collaborator['availability'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        isAvailable
                                                            ? Colors.green[700]
                                                            : Colors
                                                                .orange[700],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            collaborator['role'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),

                                          // Rating
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber[700],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                collaborator['rating']
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Connect Button
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: ElevatedButton(
                                        onPressed:
                                            () => _handleConnect(collaborator),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Text('Connect'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Skills
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Skills',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children:
                                          (collaborator['skills']
                                                  as List<String>)
                                              .map(
                                                (skill) => Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    skill,
                                                    style: TextStyle(
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
