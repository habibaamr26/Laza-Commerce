import 'package:e_commerce/core/di/dependancy_injection.dart';
import 'package:e_commerce/features/register/presentation/widgets/register_form.dart';
import 'package:e_commerce/features/register/presentation/widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(registerRepo: getIt()),
      child: BlocListener<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            // Navigate to next screen or show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!')),
            );
          } else if (state is RegisterFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: registerHeader(),
          body: const RegisterForm(),
          bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterStates>(
            builder: (context, state) {
              return SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: state is RegisterLoadingState
                      ? null
                      : () {
                    context.read<RegisterCubit>().validateAndRegister();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C7BFF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  child: state is RegisterLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}