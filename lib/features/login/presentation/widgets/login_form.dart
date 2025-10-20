import 'package:e_commerce/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/remember_me_switch.dart';

class LoginForm extends StatelessWidget {


  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
     final cubit = context.read<LoginCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: cubit.formKey, // استخدم formKey مباشرة بدون getter
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Sign Up', style: AppTextStyles.headingLarge),
            const SizedBox(height: 40),
            CustomTextField(
              label: 'Username',
              hint: 'habiba@example.com',
              controller: cubit.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Password',
              isPassword: true,
              controller: cubit.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forget Password?",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: const Color(0xFFEA4335),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const RememberMeSwitch(),
          ],
        ),
      ),
    );
  }
}
