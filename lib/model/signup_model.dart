class UserModel {
  String name = "", email = "", phone = "", password = "", occupation = "";
  int id = 0;

  UserModel(this.id,
      this.name, this.email, this.phone, this.password, this.occupation);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'occupation': occupation,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    password = map['password'];
    occupation = map['occupation'];
  }
}
