
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';


PreferredSizeWidget header()
{
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.black),
      onPressed: ()  {//Navigator.pop(context)
      },
    ),
  );
}