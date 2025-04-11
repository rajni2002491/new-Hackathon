import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Clear any user data/session here if needed
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    final user = {
      'name': 'John Doe',
      'role': 'Builder',
      'bio': 'Passionate about creating innovative solutions',
      'skills': ['Flutter', 'React', 'Node.js', 'UI/UX Design'],
      'projects': ['E-commerce App', 'Portfolio Website'],
      'socialLinks': {
        'GitHub': 'github.com/johndoe',
        'LinkedIn': 'linkedin.com/in/johndoe',
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user['name']?.toString() ?? 'No Name',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user['role']?.toString() ?? 'No Role',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('About', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              user['bio']?.toString() ?? 'No Bio Available',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text('Skills', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  (user['skills'] as List<String>)
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 24),
            Text('Projects', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...(user['projects'] as List<String>)
                .map(
                  (project) => ListTile(
                    leading: const Icon(Icons.work),
                    title: Text(project),
                  ),
                )
                .toList(),
            const SizedBox(height: 24),
            Text('Social Links', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...(user['socialLinks'] as Map<String, String>).entries
                .map(
                  (entry) => ListTile(
                    leading: Icon(
                      entry.key == 'GitHub' ? Icons.code : Icons.link,
                    ),
                    title: Text(entry.key),
                    subtitle: Text(entry.value),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
