import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/offer_model.dart';

class OffersService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Mock offers data since we don't have a real offers API
  final List<Map<String, dynamic>> _mockOffers = [
    {
      'id': 1,
      'title': 'Early Bird Special',
      'description': 'Get 30% off on all event tickets booked before midnight! Limited time offer for early bookings.',
      'discountPercentage': 30,
      'validUntil': '2025-08-30T23:59:59.000Z',
      'imageUrl': 'https://picsum.photos/400/300?random=1',
      'category': 'Early Bird',
      'isActive': true,
    },
    {
      'id': 2,
      'title': 'Student Discount',
      'description': 'Special 25% discount for students with valid student ID. Perfect for college events and workshops.',
      'discountPercentage': 25,
      'validUntil': '2025-09-15T23:59:59.000Z',
      'imageUrl': 'https://picsum.photos/400/300?random=2',
      'category': 'Student',
      'isActive': true,
    },
    {
      'id': 3,
      'title': 'Group Booking Deal',
      'description': 'Book for 5+ people and save 20% on total cost. Great for team building and corporate events.',
      'discountPercentage': 20,
      'validUntil': '2025-08-25T23:59:59.000Z',
      'imageUrl': 'https://picsum.photos/400/300?random=3',
      'category': 'Group',
      'isActive': true,
    },
    {
      'id': 4,
      'title': 'Weekend Special',
      'description': 'Extra 15% off for all weekend events. Enjoy your weekends with amazing discounts!',
      'discountPercentage': 15,
      'validUntil': '2025-08-24T23:59:59.000Z',
      'imageUrl': 'https://picsum.photos/400/300?random=4',
      'category': 'Weekend',
      'isActive': true,
    },
    {
      'id': 5,
      'title': 'VIP Experience',
      'description': 'Upgrade to VIP with 40% discount. Includes premium seating and exclusive benefits.',
      'discountPercentage': 40,
      'validUntil': '2025-09-01T23:59:59.000Z',
      'imageUrl': 'https://picsum.photos/400/300?random=5',
      'category': 'VIP',
      'isActive': true,
    },
  ];

  Future<List<Offer>> fetchOffers({int limit = 10}) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Return mock data for now
      final List<dynamic> offersData = _mockOffers.take(limit).toList();
      return offersData.map((json) => Offer.fromJson(json)).toList();

      // Uncomment below if you have a real API endpoint
      /*
      final response = await http.get(Uri.parse('$baseUrl/offers?limit=$limit'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> offers = data['offers'] ?? data;
        return offers.map((json) => Offer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load offers');
      }
      */
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Offer> fetchFeaturedOffer() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Return the best offer (highest discount)
      final offers = await fetchOffers();
      if (offers.isNotEmpty) {
        offers.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
        return offers.first;
      }

      throw Exception('No featured offer available');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Offer>> fetchOffersByCategory(String category) async {
    try {
      final allOffers = await fetchOffers();
      return allOffers.where((offer) =>
      offer.category.toLowerCase() == category.toLowerCase()
      ).toList();
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}