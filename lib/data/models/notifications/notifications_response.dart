class NotificationResponse {
  int? totalCount;
  int? currentCount;
  int? perPage;
  int? currentPage;
  int? lastPage;
  List<NotificationItem>? notifications;

  NotificationResponse(
      {this.totalCount,
        this.currentCount,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.notifications});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    currentCount = json['current_count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['notifications'] != null) {
      notifications = <NotificationItem>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['current_count'] = currentCount;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class NotificationItem {
  int? id;
  String? title;
  String? message;
  String? boldString;
  String? leftImageUrl;
  String? rightImageUrl;
  String? notificationTypeId;
  String? notifiableId;
  String? isRead;
  String? createdAt;

  NotificationItem(
      {this.id,
        this.title,
        this.message,
        this.boldString,
        this.leftImageUrl,
        this.rightImageUrl,
        this.notificationTypeId,
        this.notifiableId,
        this.isRead,
        this.createdAt});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    boldString = json['bold_string'];
    leftImageUrl = json['left_image_url'];
    rightImageUrl = json['right_image_url'];
    notificationTypeId = json['notification_type_id'];
    notifiableId = json['notifiable_id'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['bold_string'] = boldString;
    data['left_image_url'] = leftImageUrl;
    data['right_image_url'] = rightImageUrl;
    data['notification_type_id'] = notificationTypeId;
    data['notifiable_id'] = notifiableId;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    return data;
  }
}