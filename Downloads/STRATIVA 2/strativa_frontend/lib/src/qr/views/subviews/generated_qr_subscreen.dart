import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/src/qr/widgets/generated_qr_details_widget.dart';

class GeneratedQrSubscreen extends StatelessWidget {
  const GeneratedQrSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.kScanQrCodeHeader,
          style: CustomTextStyles(context).screenHeaderStyle.copyWith(
            color: ColorsCommon.kWhite,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsCommon.kPrimaryL3,
        iconTheme: IconThemeData(
          color: ColorsCommon.kWhite,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: AppConstants.kAppPadding.left,
          right: AppConstants.kAppPadding.right,
        ),
        child: Column(
          children: [
            // TODO: pass details from previous screen to here
            GeneratedQrDetailsWidget(),

            SizedBox(height: 70.h),

            AppButtonWidget(
              onTap: () {
                // TODO: generate new qr code
              },
              text: AppText.kGenerateNewQrCode,
            ),

            SizedBox(height: 5.h),

            AppButtonWidget(
              onTap: () {
                context.go(AppRoutes.kEntrypoint);
              },
              text: AppText.kGoToHome,
              showBorder: true,
              firstColor: Colors.transparent,
              secondColor: Colors.transparent,
              color: ColorsCommon.kPrimaryL3,
            ),
          ],
        ),
      ),
    );
  }
}