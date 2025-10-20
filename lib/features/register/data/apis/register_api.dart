import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networking/api_constants.dart';
import '../models/request_model.dart';
import '../models/response_model.dart';
part 'register_api.g.dart';
@RestApi(baseUrl: ApiConstants.baseUrl)

abstract class RegisterApi{

 factory RegisterApi(Dio dio, {String baseUrl}) = _RegisterApi;
 @POST( ApiConstants.register)
  Future<ResponseModel> register(@Body() RequestModel model);

}