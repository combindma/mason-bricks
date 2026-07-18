import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';
import 'api_service.dart';
import 'cms_api_service.dart';


abstract class Service {
  Service(this._ref);
  final Ref _ref;

  ApiService get api => _ref.read(apiServiceProvider);
  CmsApiService get cms => _ref.read(cmsApiServiceProvider);
  StorageService get storage => _ref.read(storageServiceProvider);

  /// Safe: `remoteConfigProvider` is eagerly initialized.
  RemoteConfigService get config => _ref.read(remoteConfigProvider).requireValue;
}