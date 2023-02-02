class Note {
  String? message;
  String timeStamp = DateTime.now().toString();
  Note(this.message);

  Note.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timeStamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "timestamp": timeStamp
  };
}