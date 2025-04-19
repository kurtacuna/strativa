import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';

class AppTransferReceiveWidget extends StatefulWidget {
  const AppTransferReceiveWidget({
    this.bottomWidget,
    required this.onTap,
    required this.title,
    super.key
  });

  // Display the content of the body dynamically
  // by passing a widget to bottomWidget
  final Widget? bottomWidget;
  final Function() onTap;
  final String title;

  @override
  State<AppTransferReceiveWidget> createState() => _AppTransferReceiveWidgetState();
}

class _AppTransferReceiveWidgetState extends State<AppTransferReceiveWidget> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhiter
          : ColorsCommon.kLightDark,
        boxShadow: Theme.of(context).brightness == Brightness.light
          ? AppConstants.kCommonBoxShadowLight
          : AppConstants.kCommonBoxShadowDark,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.kAppPadding.left,
        vertical: AppConstants.kAppPadding.top / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with arrow
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
              onTap: widget.onTap,
              child: Ink(
                padding: AppConstants.kSmallPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: CustomTextStyles(context).biggerStyle.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                
                    AppIcons.kRightArrowIcon,
                  ],
                ),
              ),
            ),
          ),

          // TODO: animate as it appears
          // Body
          widget.bottomWidget != null
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                AppDividerWidget(),
                SizedBox(height: 15.h),
                widget.bottomWidget ?? Container()
              ],
            )
            : Container()
        ]
      ),
    );
  }
}