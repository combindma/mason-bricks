import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/api_service.dart';
import 'remote_config_provider.dart';

final apiServiceProvider = Provider<ApiService>(isAutoDispose: false, (ref) {
  final config = ref.watch(remoteConfigProvider).requireValue;
  return ApiService(ref, config.apiUrl);
});