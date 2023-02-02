class NotesResponse {
  List<Notes>? notes;

  NotesResponse({this.notes});

  NotesResponse.fromJson(Map<String, dynamic> json) {
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  String? message;
  String? date;
  String? timestamp;

  Notes({this.message, this.timestamp});

  Notes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['timestamp'] = timestamp;
    data['date'] = date;
    return data;
  }
}