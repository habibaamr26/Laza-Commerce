import 'package:e_commerce/features/register/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/routs/route_constant.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/errror_dialog.dart';
import '../../../core/widgets/header.dart';
import '../../../core/widgets/success_dialog.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          showSuccessDialog(context, state.data.message!);
          Navigator.pushNamed(context, RouteConstant.login);
        } else if (state is RegisterFailureState) {
          showErrorDialog(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: header(),
        body: const RegisterForm(),
        bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return CustomButton(
              onPressed:
                  state is RegisterLoadingState
                      ? null
                      : () {
                        context.read<RegisterCubit>().validateAndRegister();
                      },
              backgroundColor: const Color(0xFF9C7BFF),
              child:
                  state is RegisterLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        "Sign Up",
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.white,
                        ),
                      ),
            );
          },
        ),
      ),
    );
  }
}
