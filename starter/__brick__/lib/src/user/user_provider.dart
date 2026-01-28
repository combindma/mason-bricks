import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'services/user_service.dart';

final userServiceProvider = Provider.autoDispose<UserService>((ref) => UserService(ref));