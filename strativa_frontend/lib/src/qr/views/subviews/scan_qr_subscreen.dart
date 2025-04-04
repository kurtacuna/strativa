import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';

class ScanQrSubScreen extends StatelessWidget {
  const ScanQrSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: ScreenUtil().screenHeight * 0.85,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        
        Positioned(
          child: Align(
            alignment: Alignment(0, 0.9),
            child: ElevatedButton(
              onPressed: () {
                // TODO: handle upload qr code
                ScaffoldMessenger.of(context).showSnackBar(
                  appSnackBarWidget(
                    context: context,
                    text: AppText.kSnackBarQrCodeWasSuccessfullyScanned,
                  )
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  ColorsCommon.kAccentL3
                ),
                overlayColor: WidgetStatePropertyAll(
                  ColorsCommon.kDarkerGray.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                AppText.kUploadQrCode,
                style: CustomTextStyles(context).defaultStyle.copyWith(
                  color: ColorsCommon.kWhite,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }
}