import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class AppDividerWidget extends StatelessWidget {
  const AppDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5,
      color: ColorsCommon.kGray
    );
  }
}