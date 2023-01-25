class FetchedState {
  int? id;
  String? state;

  FetchedState({this.id, this.state});

  FetchedState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    return data;
  }
}