class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String password;
  final int departmentId;
  final int userLevelId;
  final int workPermitRoleId;
  final String message;
  final int? loginCode;
  final String? userId;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.departmentId,
    required this.userLevelId,
    required this.workPermitRoleId,
    required this.message,
    this.loginCode,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        departmentId: json["departmentId"] ?? 0,
        userLevelId: json["userLevelId"] ?? 0,
        workPermitRoleId: json["workPermitRoleId"] ?? 0,
        message: json["message"] ?? '',
        loginCode: json["loginCode"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "departmentId": departmentId,
        "userLevelId": userLevelId,
        "workPermitRoleId": workPermitRoleId,
        "message": message,
        "loginCode": loginCode,
        "userId": userId,
      };
}
