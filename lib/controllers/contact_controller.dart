import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact_model.dart';
import '../services/api_service.dart';

final contactControllerProvider =
    StateNotifierProvider<ContactController, AsyncValue<List<Contact>>>((ref) {
      return ContactController(ref.read(apiServiceProvider));
    });

class ContactController extends StateNotifier<AsyncValue<List<Contact>>> {
  final ApiService _apiService;
  Timer? _debounceTimer;

  ContactController(this._apiService) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    search('');
  }

  void search(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() => _apiService.searchContacts(query));
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
