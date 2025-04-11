import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'New Project Invitation',
      'message': 'You have been invited to join the AI Chatbot project',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Mentor Response',
      'message': 'Dr. Smith has responded to your mentorship request',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
    },
    {
      'id': '3',
      'title': 'Project Update',
      'message': 'New features have been added to your project board',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          final timeAgo = _getTimeAgo(notification['timestamp'] as DateTime);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    notification['isRead']
                        ? Colors.grey[300]
                        : Theme.of(context).colorScheme.primary,
                child: Icon(
                  _getNotificationIcon(notification['title'] as String),
                  color:
                      notification['isRead'] ? Colors.grey[600] : Colors.white,
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: TextStyle(
                  fontWeight:
                      notification['isRead']
                          ? FontWeight.normal
                          : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message'] as String),
                  const SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                // TODO: Handle notification tap
              },
            ),
          );
        },
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  IconData _getNotificationIcon(String title) {
    if (title.contains('Project')) {
      return Icons.dashboard;
    } else if (title.contains('Mentor')) {
      return Icons.school;
    } else {
      return Icons.notifications;
    }
  }
}
