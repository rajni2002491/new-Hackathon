import 'package:flutter/material.dart';

class CollaborationRequestScreen extends StatefulWidget {
  final Map<String, dynamic> collaborator;

  const CollaborationRequestScreen({super.key, required this.collaborator});

  @override
  State<CollaborationRequestScreen> createState() =>
      _CollaborationRequestScreenState();
}

class _CollaborationRequestScreenState
    extends State<CollaborationRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _projectDetailsController = TextEditingController();
  bool _isLoading = false;
  String? _requestStatus;

  @override
  void dispose() {
    _messageController.dispose();
    _projectDetailsController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual API call to submit collaboration request
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      setState(() {
        _requestStatus = 'pending';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Collaboration request sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Collaboration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Collaborator Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        widget.collaborator['image'],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.collaborator['name'],
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.collaborator['role'],
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Request Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collaboration Request',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Message to Collaborator',
                      hintText:
                          'Introduce yourself and explain why you want to collaborate...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _projectDetailsController,
                    decoration: const InputDecoration(
                      labelText: 'Project Details',
                      hintText:
                          'Describe your project and what kind of collaboration you\'re looking for...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter project details';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitRequest,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Send Request'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Collaboration Process
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collaboration Process',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProcessStep(
                      context,
                      1,
                      'Submit Request',
                      'Send your collaboration request',
                      _requestStatus != null,
                    ),
                    _buildProcessStep(
                      context,
                      2,
                      'Review & Discussion',
                      'Collaborator reviews your request and discusses details',
                      _requestStatus == 'accepted',
                    ),
                    _buildProcessStep(
                      context,
                      3,
                      'Start Collaborating',
                      'Begin working together on the project',
                      _requestStatus == 'collaborating',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessStep(
    BuildContext context,
    int step,
    String title,
    String description,
    bool isCompleted,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isCompleted
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[300],
            ),
            child: Center(
              child:
                  isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                        step.toString(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        isCompleted
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
