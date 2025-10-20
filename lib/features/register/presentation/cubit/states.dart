
import 'package:e_commerce/core/networking/api_error_model.dart';
import 'package:e_commerce/features/register/data/models/response_model.dart';

abstract class RegisterStates {}

class InitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late ResponseModel data;
  RegisterSuccessState({required this.data});
}

class RegisterFailureState extends RegisterStates {
  late ApiErrorModel error;
  RegisterFailureState({required this.error});
}
