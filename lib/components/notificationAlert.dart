import 'package:awesome_notifications/awesome_notifications.dart';

void notificationBtn(String title, body) {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 10,
    channelKey: 'bit_chat_notification_channel',
    title: title,
    body: body,
  ));
}
