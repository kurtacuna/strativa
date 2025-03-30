import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/utils/date.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                greetUserByTimeOfDay(),
                style: CustomTextStyles(context).defaultStyle,
              ),

              Text(
                userData['first_name'],
                style: CustomTextStyles(context).defaultStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  color: ColorsCommon.kAccentL1,
                ),
              ),
            ],
          ),

          Row(
            spacing: 20,
            children: [
              InkWell(
                onTap: () {
                  // TODO: handge qr generator
                },
                borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
                child: Ink(
                  padding: AppConstants.kIconPadding,
                  child: AppIcons.kQrIcon
                ),
              ),

              GestureDetector(
                onTap: () {
                  // TODO: go to profile screen
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
                  // TODO: change to user's image
                  child: Icon(
                    Ionicons.person,
                    size: 40.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}