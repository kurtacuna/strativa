import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';

class CameraPermissionAlertDialogWidget extends StatelessWidget {
  const CameraPermissionAlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppText.kStrativaCameraPermission),
      titleTextStyle: CustomTextStyles(context).biggerStyle.copyWith(
        fontWeight: FontWeight.w900
      ),
      content: Text(AppText.kPermissionsCameraAllow),
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      actions: [
        AppTextButtonWidget(
          text: AppText.kOpenSettings,
          color: ColorsCommon.kPrimaryL4,
          onPressed: () async {
            if (await Permission.camera.isDenied) {
              await openAppSettings();
            }
          }
        )
      ],
    );
  }
}