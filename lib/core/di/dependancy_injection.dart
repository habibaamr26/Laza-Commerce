import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/login/data/data_source/local_data_source/cashing_implementation.dart';
import '../../features/login/data/data_source/remote_data_source/login_api.dart';
import '../../features/login/data/repos/login.repo.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/register/data/apis/register_api.dart';
import '../../features/register/data/repos/register_repo.dart';
import '../../features/register/presentation/cubit/cubit.dart';
import '../networking/dio_factory.dart';
import '../storage/cashing_interface.dart';

final getIt = GetIt.instance;

void appInjection() {
  _registerInjection();
  _loginInjection();
}

void _registerInjection() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<RegisterApi>(() => RegisterApi(getIt()));

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(apiService: getIt()),
  );
  getIt.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(registerRepo: getIt()),
  );
}

void _loginInjection() {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<Dio>(() => DioFactory.oFactory(getIt()));
  getIt.registerLazySingleton<LoginApi>(() => LoginApi(getIt()));

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(apiService: getIt(), authLocalDataSource: getIt()),
  );
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(loginRepo: getIt()));
}
