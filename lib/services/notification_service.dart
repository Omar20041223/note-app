import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize({String? vapidKey}) async {
    // Request notification permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Get FCM token
    final token = await _messaging.getToken(vapidKey: vapidKey);
    debugPrint('FCM Token: $token');

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Listen for messages when app is opened from terminated/background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedAppMessage);

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    if (message.notification != null) {
      debugPrint('Notification: ${message.notification}');
      // You can show a local notification here using flutter_local_notifications
    }
  }

  void _handleOpenedAppMessage(RemoteMessage message) {
    debugPrint('App opened from notification: ${message.messageId}');
    // Handle navigation or logic here
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint('Background message: ${message.messageId}');
    // Add custom background handling logic here
  }

  Future<NotificationSettings> requestPermission() async {
    return await _messaging.requestPermission();
  }

  Future<String?> getToken({String? vapidKey}) async {
    return await _messaging.getToken(vapidKey: vapidKey);
  }
}
