import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../models/filter_model.dart';
import '../models/contact_model.dart';
import '../models/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<Map<String, dynamic>> _loadData() async {
    final String response = await rootBundle.loadString(
      'assets/data/demo_data.json',
    );
    return json.decode(response);
  }

  Future<List<Ticket>> getTickets() async {
    await _delay();
    final data = await _loadData();
    final List<dynamic> ticketsJson = data['tickets'];
    return ticketsJson.map((json) => Ticket.fromJson(json)).toList();
  }

  Future<List<FilterField>> getFilters() async {
    await _delay();
    final data = await _loadData();
    final List<dynamic> filtersJson = data['filters'];
    return filtersJson.map((json) => FilterField.fromJson(json)).toList();
  }

  Future<List<Contact>> searchContacts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data = await _loadData();
    final List<dynamic> contactsJson = data['contacts'];
    final allContacts = contactsJson
        .map((json) => Contact.fromJson(json))
        .toList();

    if (query.isEmpty) return allContacts;
    return allContacts
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<User> getUserProfile() async {
    await _delay();
    final data = await _loadData();
    final userJson = data['user'];
    return User.fromJson(userJson);
  }
}
