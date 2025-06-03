import 'package:al_omda/features/auth/domain/repository/base_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuthRepository baseAuthRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthCubit(this.baseAuthRepository) : super(AuthInitial());

  login() async {
    emit(Authlodding());
    final response = await baseAuthRepository.loginUser(
      mobile: mobileController.text,
      password: passwordController.text,
    );
    response.fold(
      (errorMessage) => emit(AuthFailure(errorMassage: errorMessage)),
      (loginModel) => emit(Loginsucess()),
    );
  }
}
