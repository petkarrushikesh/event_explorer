
// Updated services/storage_service.dart - Add delete functionality
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/event_model.dart';

class StorageService {
  static const String _registeredEventsKey = 'registered_events';

  Future<void> registerForEvent(Event event, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_registeredEventsKey}_$userId';

    List<String> registeredEvents = prefs.getStringList(key) ?? [];

    // Check if already registered
    if (!registeredEvents.any((eventJson) {
      final existingEvent = Event.fromJson(json.decode(eventJson));
      return existingEvent.id == event.id;
    })) {
      registeredEvents.add(json.encode(event.toJson()));
      await prefs.setStringList(key, registeredEvents);
    }
  }

  Future<List<Event>> getRegisteredEvents(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_registeredEventsKey}_$userId';

    List<String> registeredEvents = prefs.getStringList(key) ?? [];

    return registeredEvents.map((eventJson) {
      return Event.fromJson(json.decode(eventJson));
    }).toList();
  }

  Future<bool> isRegisteredForEvent(int eventId, String userId) async {
    final registeredEvents = await getRegisteredEvents(userId);
    return registeredEvents.any((event) => event.id == eventId);
  }

  // NEW: Delete registered event
  Future<void> deleteRegisteredEvent(int eventId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_registeredEventsKey}_$userId';

    List<String> registeredEvents = prefs.getStringList(key) ?? [];

    // Remove the event with matching ID
    registeredEvents.removeWhere((eventJson) {
      final event = Event.fromJson(json.decode(eventJson));
      return event.id == eventId;
    });

    await prefs.setStringList(key, registeredEvents);
  }
}
