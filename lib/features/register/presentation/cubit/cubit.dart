import 'package:e_commerce/features/register/presentation/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request_model.dart';
import '../../data/models/response_model.dart';
import '../../data/repos/register_repo.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  late RegisterRepo registerRepo;

  RegisterCubit({required this.registerRepo}) : super(InitState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void validateAndRegister() {
    if (formKey.currentState?.validate() ?? false) {
      registerUser();
    }
  }

  Future<void> registerUser() async {
    emit(RegisterLoadingState());

    final result = await registerRepo.registerUser(
      RequestModel(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      ),
    );

    result.when(
      onSuccess: (ResponseModel data) {
        emit(RegisterSuccessState(data: data));
      },
      onError: (error) {
        print("***********************************************");
        print(error.errors.toString());
        print("***********************************************");
        emit(RegisterFailureState(errorMessage: error.message));
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}