class MyUser {
  String? id;
  String? name;
  String? email;

  MyUser({
    this.id,
    this.name,
    this.email,
  });

  MyUser.fromFirestore(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
