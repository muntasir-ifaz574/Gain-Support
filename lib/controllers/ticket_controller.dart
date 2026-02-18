import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../services/api_service.dart';

final ticketControllerProvider =
    AsyncNotifierProvider<TicketController, List<Ticket>>(TicketController.new);

class TicketController extends AsyncNotifier<List<Ticket>> {
  @override
  Future<List<Ticket>> build() async {
    return _fetchTickets();
  }

  Future<List<Ticket>> _fetchTickets() async {
    final apiService = ref.read(apiServiceProvider);
    return apiService.getTickets();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTickets());
  }

  Map<String, dynamic> _currentFilters = {};
  String _searchQuery = '';

  Future<void> applyFilter(Map<String, dynamic> filters) async {
    _currentFilters = filters;
    await _applyFiltersAndSearch();
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    await _applyFiltersAndSearch();
  }

  Future<void> _applyFiltersAndSearch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final allTickets = await _fetchTickets();
      return _filterTickets(allTickets);
    });
  }

  List<Ticket> _filterTickets(List<Ticket> tickets) {
    return tickets.where((ticket) {
      // 1. Apply Search
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final titleMatch = ticket.title.toLowerCase().contains(query);
        final idMatch = ticket.id.toString().contains(query);
        if (!titleMatch && !idMatch) return false;
      }

      // 2. Apply Filters
      if (_currentFilters.isEmpty) return true;

      if (_currentFilters.containsKey('Priority') &&
          _currentFilters['Priority'] != null) {
        if (ticket.priority != _currentFilters['Priority']) return false;
      }

      if (_currentFilters.containsKey('Brand') &&
          _currentFilters['Brand'] != null) {
        final selectedBrands = _currentFilters['Brand'] as List<String>;
        bool hasBrand = false;
        for (var brand in selectedBrands) {
          if (ticket.tags.contains(brand)) {
            hasBrand = true;
            break;
          }
        }
        if (!hasBrand && selectedBrands.isNotEmpty) return false;
      }

      if (_currentFilters.containsKey('Tags') &&
          _currentFilters['Tags'] != null) {
        final query = (_currentFilters['Tags'] as String).toLowerCase();
        if (query.isNotEmpty) {
          bool match = ticket.tags.any((t) => t.toLowerCase().contains(query));
          if (!match) return false;
        }
      }

      return true;
    }).toList();
  }

  Future<void> clearFilters() async {
    _currentFilters = {};
    _searchQuery = '';
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTickets());
  }
}
