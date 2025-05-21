class LoginModel {
  final String token;
  LoginModel({required this.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(token: json["data"]["token"]);
}
