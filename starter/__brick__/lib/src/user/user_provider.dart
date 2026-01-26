import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'services/user_service.dart';

final userServiceProvider = Provider<UserService>(isAutoDispose: false, (ref) => UserService(ref));