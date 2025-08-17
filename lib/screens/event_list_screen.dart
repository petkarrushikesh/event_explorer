import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';
import 'profile_screen.dart';
import 'offer_screen.dart';
import 'auth/login_screen.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  final PageController _pageController = PageController();
  List<Event> _events = [];
  bool _isLoading = true;
  String? _error;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const EventListContent(), // Events content only
    const OffersScreen(), // Quotes screen
    const ProfileScreen(), // Profile screen
  ];

  final List<String> _titles = ['Events', 'Offers', 'Profile'];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final fetchedEvents = await _apiService.fetchEvents();
      setState(() {
        _events = fetchedEvents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 2 // Don't show appbar on profile
          ? AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.indigoAccent,
      )
          : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              activeIcon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_quote),
              activeIcon: Icon(Icons.format_quote),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// Separate widget for just the events list content
class EventListContent extends StatefulWidget {
  const EventListContent({Key? key}) : super(key: key);

  @override
  _EventListContentState createState() => _EventListContentState();
}

class _EventListContentState extends State<EventListContent> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Event> _events = [];
  List<Event> _filteredEvents = [];
  bool _isLoading = true;
  String? _error;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final fetchedEvents = await _apiService.fetchEvents();
      setState(() {
        _events = fetchedEvents;
        _filteredEvents = fetchedEvents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredEvents = _events;
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredEvents = _events.where((event) {
          // Search in event title, description, location, etc.
          // Adjust these fields based on your Event model
          return event.title.toLowerCase().contains(query) ||
              (event.description?.toLowerCase().contains(query) ?? false) ||
              (event.location?.toLowerCase().contains(query) ?? false) ||
              (event.category?.toLowerCase().contains(query) ?? false);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _filteredEvents = _events;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search events...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _isSearching
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: _clearSearch,
              )
                  : null,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
            ),
          ),
        ),
        // Events List
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchEvents,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_filteredEvents.isEmpty && _isSearching) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No events found for "${_searchController.text}"',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _clearSearch,
              child: const Text('Clear search'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchEvents,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        itemCount: _filteredEvents.length,
        itemBuilder: (context, index) {
          final event = _filteredEvents[index];
          return EventCard(
            event: event,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailScreen(event: event),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}