



import 'package:e_commerce/core/routs/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/main/presentation/main_screen.dart';
import '../../features/register/presentation/cubit/cubit.dart';
import '../../features/register/presentation/register_screen.dart';
import '../di/dependancy_injection.dart';

class RoutGenerator{

 static Route routeGenerate(RouteSettings settings) {
   switch (settings.name) {
     case"/" :
       return MaterialPageRoute(builder: (_) => BlocProvider(
           create: (BuildContext context)=>RegisterCubit(registerRepo: getIt()),
           child: RegisterScreen()));

     case RouteConstant.login :
       return MaterialPageRoute(builder: (_) => BlocProvider(
           create: (BuildContext context)=>LoginCubit( loginRepo:  getIt(),),
           child: LoginScreen()));

     case RouteConstant.main :
       return MaterialPageRoute(builder: (_) => MainScreen()  );

   }
   return MaterialPageRoute(builder: (_) => RegisterScreen());
 }

}