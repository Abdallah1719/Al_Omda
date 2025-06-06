import 'package:al_omda/core/global_widgets/custom_buttons.dart';
import 'package:al_omda/core/global_widgets/custom_text_form_field.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                VerticalSpace(2),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Verify Phone Number',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                VerticalSpace(15),

                CustomTextFormField(
                  hintText: 'Phone Number',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    final phoneRegex = RegExp(r'^\+\d{10,15}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Invalid phone number format (e.g. +123456789)';
                    }
                    return null;
                  },

                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Send Code',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
