import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  PushNotificationService({FirebaseMessaging? messaging})
      : _messaging = messaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _messaging;

  Future<void> initialize() async {
    await _messaging.requestPermission();

    // iOS: Show notifications when app is in foreground
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Get device token (send to your backend)
  Future<String?> getToken() async => _messaging.getToken();

  /// Token refresh stream
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}