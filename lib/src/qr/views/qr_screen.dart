import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/qr/views/subviews/generate_qr_subscreen.dart';
import 'package:strativa_frontend/src/qr/views/subviews/scan_qr_subscreen.dart';
import 'package:strativa_frontend/src/qr/widgets/qr_tab_bar_widget.dart';

class QrScreen extends StatelessWidget{
  const QrScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: qrTabs.length,
      child: GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppText.kScanQrCodeHeader,
              style: CustomTextStyles(context).screenHeaderStyle,
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: QrTabBarWidget(),
            ),
          ),
          body: TabBarView(
            children: [
              ScanQrSubScreen(),
              GenerateQrSubscreen(),
            ]
          ),
        ),
      ),
    );
  }
}