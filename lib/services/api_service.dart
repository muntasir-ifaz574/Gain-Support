import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../models/filter_model.dart';
import '../models/contact_model.dart';
import '../models/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  Future<void> _delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Ticket>> getTickets() async {
    await _delay();
    return [
      Ticket(
        id: '132198423',
        title: 'Search view, which can display dynamic suggestions',
        description: '...',
        status: 'Open',
        date: DateTime.now().subtract(const Duration(days: 1)),
        senderName: 'Michale',
        priority: 'Low',
        tags: ['Low', 'Open'],
      ),
      Ticket(
        id: '132198424',
        title: 'Ticket subject small',
        description: '...',
        status: 'Open',
        date: DateTime.now().subtract(const Duration(days: 2)),
        senderName: 'Noah',
        priority: 'Urgent',
        tags: ['Urgent', 'Open', 'Spam'],
      ),
      Ticket(
        id: '132198425',
        title: 'Search view, which can display dynamic suggestions',
        description: '...',
        status: 'Closed',
        date: DateTime.now().subtract(const Duration(days: 3)),
        senderName: 'Jonus',
        priority: 'Normal',
        tags: ['Normal', 'Closed'],
      ),
    ];
  }

  Future<List<FilterField>> getFilters() async {
    await _delay();
    final jsonResponse = [
      {
        "type": "dropdown",
        "label": "Brand",
        "options": ["Gains", "GainSolution", "GainHQ"],
      },
      {
        "type": "dropdown",
        "label": "Priority",
        "options": ["Low", "Medium", "High", "Urgent"],
      },
      {"type": "text", "label": "Tags"},
    ];
    return jsonResponse.map((e) => FilterField.fromJson(e)).toList();
  }

  Future<List<Contact>> searchContacts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final allContacts = [
      Contact(
        id: '1',
        name: 'Michale Kahnwald',
        email: 'michel@email.com',
        phone: '+12 34 56 78 90',
        avatarUrl: 'https://i.pravatar.cc/150?u=1',
        location: '12A, Lillistrom, Norway',
      ),
      Contact(
        id: '2',
        name: 'Noah',
        email: 'noah@email.com',
        phone: '+12 34 56 78 90',
        avatarUrl: 'https://i.pravatar.cc/150?u=2',
        location: '12A, Lillistrom, Norway',
      ),
      Contact(
        id: '3',
        name: 'Jonus Kajhnwald',
        email: 'jonus@email.com',
        phone: '+12 34 56 78 90',
        avatarUrl: 'https://i.pravatar.cc/150?u=3',
        location: '12A, Lillistrom, Norway',
      ),
    ];

    if (query.isEmpty) return allContacts;
    return allContacts
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<User> getUserProfile() async {
    await _delay();
    return User(
      id: 'u1',
      firstName: 'Jonaus',
      lastName: 'Kahnwald',
      email: 'Username@email.com',
      avatarUrl: 'https://i.pravatar.cc/150?u=u1',
      role: 'Manager',
      group: 'Codecyaneon support',
    );
  }
}
