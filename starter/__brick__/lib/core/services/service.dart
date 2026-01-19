import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';
import 'api_service.dart';

abstract class Service {
  Service(this.ref);
  final Ref ref;

  ApiService get api => ref.read(apiServiceProvider);
  StorageService get storage => ref.read(storageServiceProvider);
}