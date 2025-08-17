import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> products = data['products'];

        return products.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}