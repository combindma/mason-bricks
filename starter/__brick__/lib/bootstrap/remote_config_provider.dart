import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/app_config.dart';

final remoteConfigProvider = FutureProvider<RemoteConfigService>(isAutoDispose: false, (ref) async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await dotenv.load();
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 24),
  ));

  await remoteConfig.setDefaults({
    'requiredMinVersion': AppConfig.requiredVersion,
    //'apiUrl': dotenv.get('API_URL', fallback: 'http://localhost/api/v1'),
  });

  await remoteConfig.fetchAndActivate();
  return RemoteConfigService(remoteConfig);
});

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  RemoteConfigService(this._remoteConfig);

  String get requiredMinVersion => _remoteConfig.getString('requiredMinVersion');
  String get privacyUrl => _remoteConfig.getString('privacyUrl');
  String get cgvUrl => _remoteConfig.getString('cgvUrl');
}