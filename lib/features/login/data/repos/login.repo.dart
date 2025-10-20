import 'package:e_commerce/features/login/data/models/response.dart';

import '../../../../core/helper/cash_helper.dart';
import '../../../../core/networking/result.dart';

import '../../../../core/storage/cashing_interface.dart';
import '../data_source/remote_data_source/login_api.dart';
import '../models/request.dart';

class LoginRepo {
  LoginApi apiService;
  AuthLocalDataSource authLocalDataSource;
  LoginRepo({required this.apiService,required this.authLocalDataSource});

  Future<ApiResult<LoginResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await apiService.login(requestModel);
      authLocalDataSource.saveTokens(accessToken: response.accessToken!, refreshToken:  response.refreshToken!);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(error);
    }
  }
}
