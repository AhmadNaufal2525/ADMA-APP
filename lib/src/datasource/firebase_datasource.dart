import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sima_app/firebase_options.dart';
import 'package:sima_app/src/utils/colors.dart';

class FirebaseApi {
  final FirebaseMessaging notification = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await notification.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initializeAwesomeNotifications();
    subscribeAcceptPeminjaman();
    subscribeAcceptPengembalian();
    subscribeRejectPeminjaman();
    subscribeRejectPengembalian();
  }

  Future<void> initializeAwesomeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'key1',
          channelName: 'Pengajuan Notification',
          channelDescription: 'Notification channel untuk pengjauan',
          defaultColor: AppColor.primaryColor,
          ledColor: AppColor.primaryColor,
          playSound: true,
          enableLights: true,
          enableVibration: true,
        ),
      ],
    );
  }

  void subscribeAcceptPeminjaman() async {
    await notification.subscribeToTopic('accept_peminjaman');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  void subscribeRejectPeminjaman() async {
    await notification.subscribeToTopic('reject_peminjaman');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  void subscribeAcceptPengembalian() async {
    await notification.subscribeToTopic('accept_pengembalian');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  void subscribeRejectPengembalian() async {
    await notification.subscribeToTopic('reject_pengembalian');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }
}
