import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/api_service.dart';

final apiServiceProvider = Provider.autoDispose<ApiService>((ref) => ApiService(ref));