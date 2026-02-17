import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/filter_model.dart';
import '../services/api_service.dart';

final filterControllerProvider = FutureProvider<List<FilterField>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.getFilters();
});

final selectedFiltersProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
);
