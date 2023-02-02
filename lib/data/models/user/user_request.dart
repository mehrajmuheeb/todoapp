class UserRequest {
  String id;
  String name;
  String email;
  String image;

  UserRequest(this.id, this.name, this.email, this.image);

  Map<String, String> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
  };
}