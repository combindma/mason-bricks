import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'services/auth_service.dart';

final authServiceProvider = Provider.autoDispose<AuthService>((ref) => AuthService());