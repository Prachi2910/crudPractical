class UserData {
  String? email;
  String? firstName;
  String? userName;
  String? lastName;
  String? password;

  UserData(
      {this.email,
      this.firstName,
      this.userName,
      this.lastName,
      this.password});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        email: json['email'],
        firstName: json['firstName'],
        userName: json['userName'],
        lastName: json['lastName'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    return data;
  }
}
