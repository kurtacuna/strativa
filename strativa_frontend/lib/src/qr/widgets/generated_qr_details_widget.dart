import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kresources.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:strativa_frontend/src/qr/controllers/generate_qr_account_modal_notifier.dart';

class GeneratedQrDetailsWidget extends StatelessWidget {
  const GeneratedQrDetailsWidget({
    required this.type,
    required this.accountNumber,
    required this.amountRequested,
    super.key
  });

  final String type;
  final String accountNumber;
  final String amountRequested;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhiter
          : ColorsCommon.kLightDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.kAppBorderRadius),
          bottomRight: Radius.circular(AppConstants.kAppBorderRadius)
        ),
        boxShadow: Theme.of(context).brightness == Brightness.light
          ? AppConstants.kCommonBoxShadowLight
          : AppConstants.kCommonBoxShadowDark,
      ),
      child: Column(
        children: [
          Padding(
            padding: AppConstants.kAppPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                // QR Code
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: PrettyQrView.data(
                      data: "$type, $accountNumber, $amountRequested",
                      decoration: const PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                          image: AssetImage(R.ASSETS_IMAGES_LOGO_PNG),
                          scale: 0.1
                        ),
                        shape: PrettyQrSmoothSymbol(
                          color: ColorsCommon.kPrimaryL1
                        )
                      )
                    )
                  ),
                ),
          
                SizedBox(height: 40.h),
          
                Text(
                  AppText.kDepositTo,
                  style: CustomTextStyles(context).biggerStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                Text(
                  type.toUpperCase(),
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
    
                SizedBox(height: 10.h),
    
                Text(
                  accountNumber,
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),
    
                context.read<GenerateQrAccountModalNotifier>().getSpecifyAmount == true
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),

                      Text(
                        AppText.kAmountRequested,
                        style: CustomTextStyles(context).defaultStyle.copyWith(
                          color: ColorsCommon.kDarkerGray,
                        ),
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppAmountWidget(
                            amount: removeCommaFromAmount(amountRequested),
                          ),
                        ]
                      ),
                    ]
                  )
                  : Container()
              ]
            ),
          ),
          
          SizedBox(height: 10.h),
    
          AppDividerWidget(),
    
          // Edit and Share buttons
          Padding(
            padding: AppConstants.kAppPadding / 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double parentWidth = constraints.maxWidth;
                return Row(
                  children: [
                    SizedBox(
                      width: parentWidth / 2,
                      child: AppTextButtonWidget(
                        onPressed: () {
                          context.pop();
                        },
                        prefixIcon: AppIcons.kEditIcon,
                        text: AppText.kEdit.toUpperCase(),
                        color: ColorsCommon.kDarkerGray,
                        spacing: 10,
                        overlayColor: ColorsCommon.kAccentL2,
                      ),
                    ),
    
                    SizedBox(
                      width: parentWidth / 2,
                      child: AppTextButtonWidget(
                        onPressed: () {
                          // TODO: handle share
                        },
                        prefixIcon: AppIcons.kShareIcon,
                        text: AppText.kShare.toUpperCase(),
                        spacing: 10,
                        overlayColor: ColorsCommon.kAccentL3,
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}