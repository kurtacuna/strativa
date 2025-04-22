import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kenums.dart';

class QrTabBarWidget extends StatelessWidget {
  const QrTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: ColorsCommon.kGray,
      dividerHeight: 2,
      indicatorWeight: 4,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: ColorsCommon.kPrimaryL3,
      labelColor: ColorsCommon.kPrimaryL3,
      labelStyle: CustomTextStyles(context).bigStyle.copyWith(
        fontWeight: FontWeight.w900,
      ),
      unselectedLabelColor: ColorsCommon.kDarkerGray,
      overlayColor: WidgetStatePropertyAll(
        ColorsCommon.kPrimaryL3.withValues(alpha: 0.1)
      ),
      tabs: List.generate(qrTabs.length, (index) {
        return Tab(
          text: qrTabs[index]
        );
      })
    );
  }
}