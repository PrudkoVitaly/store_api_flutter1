import 'package:flutter/cupertino.dart';

class UsersModal with ChangeNotifier{
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  UsersModal(
      {this.id, this.email, this.password, this.name, this.role, this.avatar});

  UsersModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
  }

  // Метод который принимает (List usersJson) саисок продуктов, перебирает и возвращает его
  static List<UsersModal> usersFromJson(List usersJson) {
    return usersJson.map((data) {
      return UsersModal.fromJson(data);
    }).toList();
  }
}