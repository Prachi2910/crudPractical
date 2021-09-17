import 'package:practical/src/model/support.response.dart';

class UsersListModel {
  List<UserModel>? data;
  int? page;
  int? perPage;
  Support? support;
  int? total;
  int? totalPages;

  UsersListModel(
      {this.data,
      this.page,
      this.perPage,
      this.support,
      this.total,
      this.totalPages});

  factory UsersListModel.fromJson(Map<String, dynamic> json) {
    return UsersListModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => UserModel.fromJson(i)).toList()
          : null,
      page: json['page'],
      perPage: json['per_page'],
      support:
          json['support'] != null ? Support.fromJson(json['support']) : null,
      total: json['total'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support?.toJson();
    }
    return data;
  }
}

class UserModel {
  String? avatar;
  String? email;
  String? firstName;
  int? id;
  String? lastName;

  UserModel({this.avatar, this.email, this.firstName, this.id, this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'],
      email: json['email'],
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    return data;
  }
}
