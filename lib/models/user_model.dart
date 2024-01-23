import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String name;
  String email;
  String password;
  int departmentId;
  int userLevelId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.departmentId,
    required this.userLevelId,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      departmentId: json["departmentID"],
      userLevelId: json["userLevelId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "departmentId": departmentId,
        "userLevelId": userLevelId,
      };
}
