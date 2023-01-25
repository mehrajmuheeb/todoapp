class ToggleNotificationRequest {
  bool isNotificationEnabled;

  ToggleNotificationRequest(this.isNotificationEnabled);

  Map toJson() => {
    "is_notification_enabled": isNotificationEnabled
  };
}