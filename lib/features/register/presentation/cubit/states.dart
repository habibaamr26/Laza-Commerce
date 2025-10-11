
import 'package:e_commerce/features/register/data/models/response_model.dart';

abstract class RegisterStates {}

class InitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late ResponseModel data;
  RegisterSuccessState({required this.data});
}

class RegisterFailureState extends RegisterStates {
  late String errorMessage;
  RegisterFailureState({required this.errorMessage});
}
