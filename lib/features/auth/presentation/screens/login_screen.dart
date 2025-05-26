import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/app_assets.dart';
import 'package:al_omda/core/utils/index.dart';
import 'package:al_omda/features/auth/presentation/components/custom_app_bar.dart';
import 'package:al_omda/features/auth/presentation/components/custom_text_field.dart';
import 'package:al_omda/features/auth/presentation/components/primary_button.dart';
import 'package:al_omda/features/auth/presentation/components/secondary_button.dart';
import 'package:al_omda/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // 👇 هنا نضع المنطق الذي يتعامل مع الـ Navigation
          if (state is Loginsucess) {
            RoutesMethods.customReplacementNavigate(context, '/home');
            // أو اسم الروت بتاع الصفحة الرئيسية
          } else if (state is Loginfailure) {
            // 👇 عرض رسالة خطأ للمستخدم
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMassage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        builder: (context, state) {
          var c = context.read<AuthCubit>();
          return Scaffold(
            backgroundColor: R.colors.white,
            appBar: CustomAppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: [
                    Form(
                      key: c.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.imagesOmdaLogo, height: 100),

                          const SizedBox(height: 32),

                          Align(
                            // alignment:
                            // LocaleCubit.isArabic()
                            //     ? Alignment.centerRight
                            //     : Alignment.centerLeft,
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),

                          const SizedBox(height: 24),

                          CustomTextFormField(
                            hintText: 'Phone or Email',
                            controller: c.mobileController,
                          ),

                          CustomTextFormField(
                            hintText: 'Password',
                            obscureText: true,
                            controller: c.passwordController,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(color: R.colors.darkgreen),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          PrimaryButton(
                            text: 'LOGIN',
                            onPressed: () {
                              c.login();
                            },
                          ),

                          const SizedBox(height: 16),

                          SecondaryButton(
                            text: "Don't have an account? Register",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
