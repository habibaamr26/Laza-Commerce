import 'package:e_commerce/features/login/data/models/request.dart';
import 'package:e_commerce/features/login/presentation/cubit/login_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/login.repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit({required this.loginRepo}) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      final user = await loginRepo.login(
        LoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      emit(LoginSuccessState(user: user));
    } catch (e) {
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }
}
