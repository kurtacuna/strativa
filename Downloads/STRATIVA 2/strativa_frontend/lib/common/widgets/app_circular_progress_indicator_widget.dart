import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class AppCircularProgressIndicatorWidget extends StatelessWidget {
  const AppCircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: ColorsCommon.kPrimaryL4,
      valueColor: AlwaysStoppedAnimation(
        ColorsCommon.kWhite,
      )
    );
  }
}