import 'package:flutter/material.dart';
import 'user_model.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedRole = 'All';
  final List<String> _roles = ['All', 'Student', 'Professional', 'Mentor'];

  // Dummy data for demonstration
  final List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'Student',
      skills: ['Flutter', 'UI/UX'],
      interests: ['Mobile Development', 'Design'],
      projects: ['E-commerce App', 'Portfolio Website'],
      bio: 'Passionate about mobile development',
    ),
    UserModel(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'Mentor',
      skills: ['React', 'Node.js', 'MongoDB'],
      interests: ['Web Development', 'Teaching'],
      projects: ['Learning Platform', 'Blog'],
      bio: 'Experienced web developer and mentor',
    ),
  ];

  List<UserModel> get _filteredUsers {
    return _users.where((user) {
      final matchesSearch =
          user.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          user.skills.any(
            (skill) => skill.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          );
      final matchesRole = _selectedRole == 'All' || user.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EdTech Network'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: _users[0]),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    subtitle: Text('${user.role} • ${user.skills.join(", ")}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement create project/team functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
