import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/qr/controllers/scan_qr_notifier.dart';

class ScannedQrSubscreen extends StatelessWidget {
  const ScannedQrSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder:(context) {
            return IconButton(
              onPressed: () {
                // context.read<ScanQrNotifier>().getScannerController.start();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          AppText.kReview,
          style: CustomTextStyles(context).screenHeaderStyle.copyWith(
            color: ColorsCommon.kWhite,
          ),
        ),
        backgroundColor: ColorsCommon.kPrimaryL3,
        iconTheme: IconThemeData(
          color: ColorsCommon.kWhite,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: AppConstants.kAppPadding.left,
          right: AppConstants.kAppPadding.right
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Scanned QR Details
              Container(
                width: ScreenUtil().screenWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppConstants.kAppBorderRadius),
                    bottomRight: Radius.circular(AppConstants.kAppBorderRadius),
                  )
                ),
              ) 
            ]
          )
        )
      )
    );
  }
}