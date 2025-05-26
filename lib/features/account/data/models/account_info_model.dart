// class AccountInfoModel {
//   final String firstName;
//   final String lastName;
//   final String email;

//   AccountInfoModel({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//   });
//   factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
//       AccountInfoModel(
//         firstName: json["user"]["first_name"],
//         lastName: json["user"]["last_name"],
//         email: json["user"]["email"],
//       );
// }
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
    // ندخل إلى data > user
    final userData = json['data']['user'];

    return AccountInfoModel(
      firstName: userData['first_name'] ?? '',
      lastName: userData['last_name'] ?? '',
      email: userData['email'] ?? '',
    );
  }
}
