import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/register/data/apis/register_api.dart';
import '../../features/register/data/repos/register_repo.dart';
import '../../features/register/presentation/cubit/cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

void appInjection() {
  _registerInjection();
}

void _registerInjection() {
  getIt.registerLazySingleton<Dio>(() => DioFactory.oFactory());
  getIt.registerLazySingleton<RegisterApi>(() => RegisterApi(getIt()));

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(apiService: getIt()),
  );
  getIt.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(registerRepo: getIt()),
  );
}
