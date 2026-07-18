import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/cms_api_service.dart';
import 'providers.dart';

final cmsApiServiceProvider = Provider<CmsApiService>(isAutoDispose: false, (ref) {
  final config = ref.watch(remoteConfigProvider).requireValue;
  return CmsApiService(baseUrl: config.cmsApiUrl, token: config.cmsApiToken);
});
