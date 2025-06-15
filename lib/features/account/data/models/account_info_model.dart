class AccountInfoModel {
  final String firstName;
  final String lastName;
  final String email;

  AccountInfoModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    final userData = json['data']['user'];
    return AccountInfoModel(
      firstName: userData['first_name'] ?? '',
      lastName: userData['last_name'] ?? '',
      email: userData['email'] ?? '',
    );
  }
}
