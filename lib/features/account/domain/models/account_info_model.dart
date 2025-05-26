class AccountInfoModel {
  final String firstName;
  final String lastName;
  final String email;

  AccountInfoModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      AccountInfoModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );
}
