

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';


class RememberMeSwitch extends StatelessWidget {
  const RememberMeSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Text(
          'Remember me',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        const Spacer(),
        CostumeSwitch(),
      ],
    );
  }
}

class CostumeSwitch extends StatefulWidget {
  const CostumeSwitch({super.key});

  @override
  State<CostumeSwitch> createState() => _CostumeSwitchState();
}
class _CostumeSwitchState extends State<CostumeSwitch> {
  bool  isSwitched=true;
  @override
  Widget build(BuildContext context) {
    return  Switch(
      value: isSwitched,
      onChanged: (bool newValue) {
        setState(() => isSwitched = newValue);
      },
      activeColor: Colors.white,          // لون الدائرة لما تكون ON
      activeTrackColor: Colors.green,     // لون الخلفية لما تكون ON
      inactiveThumbColor: Colors.grey,    // لون الدائرة لما تكون OFF
      inactiveTrackColor: Colors.black26, // لون الخلفية لما تكون OFF
    );
  }
}

