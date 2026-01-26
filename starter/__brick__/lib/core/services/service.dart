import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';

abstract class Service {
  Service(this._ref);
  final Ref _ref;

  //ApiService get _api => ref.read(apiServiceProvider);
  StorageService get storage => _ref.read(storageServiceProvider);
}