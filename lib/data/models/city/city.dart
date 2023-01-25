class City {
  int? id;
  String? city;
  String? zipcode;

  City({this.id, this.city, this.zipcode});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['zipcode'] = zipcode;
    return data;
  }
}