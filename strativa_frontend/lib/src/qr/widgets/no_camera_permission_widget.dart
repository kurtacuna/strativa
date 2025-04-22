import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
import 'package:strativa_frontend/src/qr/widgets/camera_permission_alert_dialog_widget.dart';

class NoCameraPermissionWidget extends StatelessWidget {
  const NoCameraPermissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      color: ColorsCommon.kDark,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppText.kQrPermissionRequired,
              style: CustomTextStyles(context).biggerStyle.copyWith(
                color: ColorsCommon.kGray
              )
            ),
      
            AppTextButtonWidget(
              text: AppText.kOpenSettings,
              color: ColorsCommon.kAccentL3,
              overlayColor: ColorsCommon.kAccentL4,
              onPressed: () async {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return CameraPermissionAlertDialogWidget();
                  }
                );
              },
            )
          ],
        )
      ),
    );
  }
}