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
    subscribeToNotificationTopics();
    configureFirebaseMessaging();
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

  void subscribeToNotificationTopics() async {
    await notification.subscribeToTopic('accept_peminjaman');
    await notification.subscribeToTopic('reject_peminjaman');
    await notification.subscribeToTopic('accept_pengembalian');
    await notification.subscribeToTopic('reject_pengembalian');
  }

  void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleReceivedMessage(message);
    });
  }

  void handleReceivedMessage(RemoteMessage message) {
    if (message.data.containsKey('type')) {
      String messageType = message.data['type'];

      if (messageType == 'accept_peminjaman') {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body,
          ),
        );
      } else if (messageType == 'reject_peminjaman') {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 2,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body,
          ),
        );
      } else if (messageType == 'accept_pengembalian') {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 3,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body,
          ),
        );
      } else if (messageType == 'reject_pengembalian') {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 4,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body,
          ),
        );
      }
    }
  }
}
