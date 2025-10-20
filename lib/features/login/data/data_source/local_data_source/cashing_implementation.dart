



import '../../../../../core/helper/cash_helper.dart';
import '../../../../../core/storage/cashing_interface.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource
{
  @override
  Future<void> clearTokens() async {
   await Caching.deleteAllSecureStorage();
  }

  @override
  Future<String?> getAccessToken()async {
   return await Caching.getSecureStorage(key: "accessToken");
  }

  @override
  Future<String?> getRefreshToken() async{
    return await Caching.getSecureStorage(key: "refreshToken");
  }

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
   await Caching.setSecureStorage(key: "accessToken", value: accessToken);
   await Caching.setSecureStorage(key: "refreshToken", value: refreshToken);
  }

}