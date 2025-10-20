import 'package:e_commerce/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routs/route_constant.dart';
import '../../../core/widgets/header.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';


class LoginScreen extends StatelessWidget {


  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful!')),
          ) ;
          Navigator.pushNamed(context, RouteConstant.main);
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
    
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: header(),
        body:  LoginForm(),
        bottomNavigationBar: BlocBuilder<LoginCubit,LoginState>(
          builder: (BuildContext context, state) {
            return  SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C7BFF),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Login",
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
    );

  }
}

