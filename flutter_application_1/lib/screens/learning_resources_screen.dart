import 'package:flutter/material.dart';

class LearningResourcesScreen extends StatelessWidget {
  const LearningResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Resources'),
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildResourceCard(
              context,
              'Flutter Development',
              'Learn Flutter app development from scratch',
              Icons.mobile_friendly,
              Colors.blue,
              () {
                // TODO: Navigate to Flutter course
              },
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              'UI/UX Design',
              'Master the principles of modern UI/UX design',
              Icons.design_services,
              Colors.purple,
              () {
                // TODO: Navigate to UI/UX course
              },
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              'Project Management',
              'Learn agile and scrum methodologies',
              Icons.assignment,
              Colors.orange,
              () {
                // TODO: Navigate to PM course
              },
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              'Cloud Computing',
              'Explore AWS, Azure, and Google Cloud',
              Icons.cloud,
              Colors.green,
              () {
                // TODO: Navigate to cloud computing course
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
