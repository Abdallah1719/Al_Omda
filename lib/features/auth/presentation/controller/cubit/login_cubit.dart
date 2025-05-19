import 'package:al_omda/features/auth/data/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginCubit(this.loginRepository) : super(LoginInitial());

  login() async {
    emit(Loginlodding());
    final response = await loginRepository.loginUser(
      mobile: mobileController.text,
      password: passwordController.text,
    );
    response.fold(
      (errorMessage) => emit(Loginfailure(errorMassage: errorMessage.message)),
      (loginModel) => emit(Loginsucess()),
    );
  }
}
