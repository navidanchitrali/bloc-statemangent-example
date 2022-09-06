// ignore_for_file: unnecessary_this

class AppUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  AppUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  AppUser.fromJson(Map<String, dynamic> json, uid) {
    id = uid;
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
}
