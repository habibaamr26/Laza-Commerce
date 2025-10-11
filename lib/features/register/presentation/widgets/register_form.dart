

import 'package:e_commerce/features/register/presentation/widgets/remember_me_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/cubit.dart';
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

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
              controller: cubit.emailController,
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
              controller: cubit.passwordController,
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
            const SizedBox(height: 10),
            CustomTextField(
              label: 'First Name',
              controller: cubit.firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your First Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Last Name',
              controller: cubit.lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const RememberMeSwitch(),
          ],
        ),
      ),
    );
  }
}