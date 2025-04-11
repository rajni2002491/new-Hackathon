import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      user['name'][0],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user['name'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    user['role'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('About', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(user['bio']),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement message functionality
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement collaboration request
                  },
                  icon: const Icon(Icons.group_add),
                  label: const Text('Request to Collaborate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
