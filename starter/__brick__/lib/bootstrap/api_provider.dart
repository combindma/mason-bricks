import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>(isAutoDispose: false, (ref) => ApiService(ref));