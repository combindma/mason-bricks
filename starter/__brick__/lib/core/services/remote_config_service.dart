import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../config/app_config.dart';

class RemoteConfigService {
  RemoteConfigService._();
  static final RemoteConfigService _instance = RemoteConfigService._();
  factory RemoteConfigService() => _instance;

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static const String _requiredMinVersion = 'requiredMinVersion';
  static const String _webUrlKey = 'webUrl';
  static const String _apiUrlKey = 'apiUrl';

  static String get requiredMinVersion => _remoteConfig.getString(_requiredMinVersion);

  static String get webUrl => _remoteConfig.getString(_webUrlKey);

  static String get apiUrl => _remoteConfig.getString(_apiUrlKey);

  Future<void> init() async {
    await dotenv.load();
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 24),
    ));

    // Set default values
    await _remoteConfig.setDefaults({
      _requiredMinVersion: AppConfig.requiredVersion,
      _webUrlKey: dotenv.get('WEB_URL', fallback: 'https://'),//TODO
      _apiUrlKey: dotenv.get('API_URL', fallback: 'https://'),//TODO
    });

    // Fetch and activate
    await _remoteConfig.fetchAndActivate();
  }
}