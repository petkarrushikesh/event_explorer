import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();
  bool _isRegistered = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    final userId = _authService.currentUser?.uid;
    if (userId != null) {
      final isRegistered = await _storageService.isRegisteredForEvent(
        widget.event.id,
        userId,
      );
      setState(() => _isRegistered = isRegistered);
    }
  }

  Future<void> _registerForEvent() async {
    final userId = _authService.currentUser?.uid;
    if (userId == null) return;

    setState(() => _isLoading = true);

    try {
      await _storageService.registerForEvent(widget.event, userId);
      setState(() => _isRegistered = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully registered for event!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error registering for event: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.event.image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.event, size: 80, color: Colors.grey),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today, 'Date', widget.event.formattedDate),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.location_on, 'Location', widget.event.location),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.category, 'Category', widget.event.category),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.attach_money, 'Price', '\$${widget.event.price.toStringAsFixed(2)}'),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.event.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isRegistered ? null : (_isLoading ? null : _registerForEvent),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRegistered ? Colors.grey : Colors.blue,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(_isRegistered ? 'Already Registered' : 'Register for Event'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}