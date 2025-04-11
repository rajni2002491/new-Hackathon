import 'package:flutter/material.dart';
import 'user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel _user;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              items
                  .map(
                    (item) => Chip(
                      label: Text(item),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
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
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      _user.name[0],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _user.role,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_isEditing) ...[
              TextField(
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
                controller: TextEditingController(text: _user.bio),
                onChanged: (value) {
                  _user = _user.copyWith(bio: value);
                },
              ),
              const SizedBox(height: 16),
            ] else
              Text(_user.bio, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            _buildInfoSection('Skills', _user.skills),
            _buildInfoSection('Interests', _user.interests),
            _buildInfoSection('Projects', _user.projects),
          ],
        ),
      ),
    );
  }
}
