

import 'package:dio/dio.dart';
import 'package:e_commerce/features/login/data/models/request.dart';
import 'package:e_commerce/features/login/data/models/response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../../core/networking/api_constants.dart';


part 'login_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LoginApi {
  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel requestModel);
}
