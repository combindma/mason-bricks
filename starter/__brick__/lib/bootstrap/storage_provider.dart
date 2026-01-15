import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/storage_service.dart';

final storageServiceProvider = Provider<StorageService>(isAutoDispose: false, (ref) => StorageService());
