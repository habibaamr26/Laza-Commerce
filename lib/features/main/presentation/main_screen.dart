

import 'package:flutter/material.dart';

import '../../../core/storage/cashing_interface.dart';
import '../../login/data/data_source/local_data_source/cashing_implementation.dart';

class MainScreen extends StatelessWidget  {
  AuthLocalDataSource x=AuthLocalDataSourceImpl();
  late String? token;
  getToken() async
  {
    token= await x.getAccessToken();
  }

   MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(token!)),
    );
  }
}
