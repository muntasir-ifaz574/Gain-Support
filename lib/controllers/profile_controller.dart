import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

final profileControllerProvider = FutureProvider<User>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.getUserProfile();
});
