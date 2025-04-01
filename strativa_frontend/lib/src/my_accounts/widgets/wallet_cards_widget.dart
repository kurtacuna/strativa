import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kresources.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/card_widget.dart';

class WalletCardsWidget extends StatelessWidget {
  const WalletCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceNotifier> (
      builder: (context, balanceNotifier, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kWalletCardsHeader.toUpperCase(),
              style: CustomTextStyles(context).smallStyle.copyWith(
                color: ColorsCommon.kDarkerGray,
              ),
            ),
        
            SizedBox(height: 10.h),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CardWidget(
                          width: 180.w,
                          height: 120.h,
                          secondColor: ColorsCommon.kDark,
                        ),
                        
                        Positioned(
                          child: Image.asset(
                            R.ASSETS_IMAGES_CARD_BACKGROUND_PNG,
                            width: 180.w,
                            height: 120.h,
                          ),
                        ),
                        
                        Positioned(
                          top: (120.h / 2) - (AppIcons.kSimIcon.height! / 2),
                          left: AppConstants.kCardPadding.left,
                          child: AppIcons.kSimIcon,
                        ),
        
                        Positioned(
                          left: AppConstants.kCardPadding.left,
                          bottom: AppConstants.kCardPadding.bottom,
                          child: Text(
                            balanceNotifier.getShowBalance
                            ? "@${userData['user_id']}"
                            : "••••",
                            style: CustomTextStyles(context).smallestStyle.copyWith(
                              color: ColorsCommon.kWhite,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ]
                    ),
        
                    SizedBox(
                      height: 5.h,
                    ),
        
                    Text(
                      AppText.kMyStrativaCard,
                      style: CustomTextStyles(context).smallerStyle,
                    ),
                  ],
                ),
        
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CardWidget(
                          width: 180.w,
                          height: 120.h,
                          firstColor: ColorsCommon.kAccentL2,
                          secondColor: ColorsCommon.kDark,
                        ),

                        Positioned(
                          child: Image.asset(
                            R.ASSETS_IMAGES_CARD_BACKGROUND_PNG,
                            width: 180.w,
                            height: 120.h,
                          ),
                        ),
                        
                        userData['online_card_details'].isEmpty
                        ? Stack(
                          children: [    
                            Positioned(
                              child: Container(
                                width: 180.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppConstants.kCardRadius),
                                  color: ColorsCommon.kWhite.withValues(alpha: 0.5)
                                ),
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: handle activate online card
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(ColorsCommon.kAccentL2),
                                    ),
                                    child: Text(
                                      AppText.kActivateNow,
                                      style: CustomTextStyles(context).smallestStyle.copyWith(
                                        color: ColorsCommon.kWhite,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
        
                            Positioned(
                              left: -3,
                              top: -3,
                              child: AppIcons.kFreeIcon,
                            ),
                          ],
                        )
                        : Positioned(
                          left: AppConstants.kCardPadding.left,
                          bottom: AppConstants.kCardPadding.bottom,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                balanceNotifier.getShowBalance
                                ? "${userData['online_card_details']['online_card_number']}"
                                : "•••• •••• •••• ••••",
                                style: CustomTextStyles(context).smallestStyle.copyWith(
                                  color: ColorsCommon.kWhite,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
        
                              Text(
                                balanceNotifier.getShowBalance
                                ? "@${userData['user_id']}"
                                : "••••",
                                style: CustomTextStyles(context).smallestStyle.copyWith(
                                  color: ColorsCommon.kWhite,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
        
                    SizedBox(
                      height: 5.h,
                    ),
        
                    Text(
                      AppText.kMyOnlineCard,
                      style: CustomTextStyles(context).smallerStyle,
                    ),
                  ],
                ),
              ]
            ),
          ]
        );
      }
    );
  }
}