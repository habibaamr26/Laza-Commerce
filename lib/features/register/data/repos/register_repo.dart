
import '../../../../core/networking/result.dart';
import '../apis/register_api.dart';
import '../models/request_model.dart';
import '../models/response_model.dart';

class RegisterRepo {
  final RegisterApi apiService;

  RegisterRepo({required this.apiService});

  Future<ApiResult<ResponseModel>> registerUser(RequestModel model) async {
    try {
      final response = await apiService.register(model);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(error);

    }
  }
}
