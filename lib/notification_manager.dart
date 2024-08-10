// notification_manager.dart
class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  NotificationManager._internal();

  String _message = '';

  String get message => _message;
  set message(String msg) => _message = msg;
}