



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/register/presentation/cubit/cubit.dart';
import '../../features/register/presentation/register_screen.dart';
import '../di/dependancy_injection.dart';

class RoutGenerator{

 static Route routeGenerate(RouteSettings settings) {
   switch (settings.name) {
     case "/" :
       return MaterialPageRoute(builder: (_) => BlocProvider(
           create: (BuildContext context)=>RegisterCubit(registerRepo: getIt()),
           child: RegisterScreen()));
   }
   return MaterialPageRoute(builder: (_) => RegisterScreen());
 }

}