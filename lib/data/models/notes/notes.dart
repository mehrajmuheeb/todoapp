class Note {
  String? message;
  String? date;
  String timeStamp = DateTime.now().toString();
  Note(this.message, this.date);

  Note.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    timeStamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "date": date,
    "timestamp": timeStamp
  };
}