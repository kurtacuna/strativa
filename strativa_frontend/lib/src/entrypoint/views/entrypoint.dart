import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/entrypoint/controllers/bottom_nav_notifier.dart';
import 'package:strativa_frontend/src/invest/views/invest_screen.dart';
import 'package:strativa_frontend/src/my_accounts/views/my_accounts_screen.dart';
import 'package:strativa_frontend/src/payload/views/payload_screen.dart';
import 'package:strativa_frontend/src/profile/views/profile_screen.dart';
import 'package:strativa_frontend/src/transfer/views/transfer_screen.dart';

class Entrypoint extends StatelessWidget {
  const Entrypoint({super.key});

  static const List<Widget> pages = [
    MyAccountsScreen(),
    TransferScreen(),
    PayloadScreen(),
    InvestScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavNotifier>(
        builder: (context, bottomNavNotifier, child) {
          return Stack(
            children: [
              pages[bottomNavNotifier.getIndex],

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.kAppBorderRadius),
                      topRight: Radius.circular(AppConstants.kAppBorderRadius),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.light
                          ? ColorsCommon.kGray
                          : ColorsCommon.kDarkGray,
                        blurRadius: 100,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.kAppBorderRadius),
                      topRight: Radius.circular(AppConstants.kAppBorderRadius),
                    ),
                    child: BottomNavigationBar(
                      onTap: (index) {
                        bottomNavNotifier.setIndex = index;
                      },
                      currentIndex: bottomNavNotifier.getIndex,
                      selectedItemColor: ColorsCommon.kAccentL2,
                      unselectedItemColor: ColorsCommon.kGray,
                      selectedFontSize: CustomTextStyles(context).smallerStyle.fontSize!,
                      items: [
                        BottomNavigationBarItem(
                          icon: AppIcons.kBottomNavBarMyAccountsIcon(
                            colorFilter: bottomNavNotifier.getIndex == 0
                              ? ColorFilter.mode(
                                ColorsCommon.kAccentL2,
                                BlendMode.srcIn,
                              )
                              : Theme.of(context).brightness == Brightness.dark
                                ? ColorFilter.mode(
                                  ColorsCommon.kWhite,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          ),
                          label: AppText.kBottomNavBarMyAccounts,
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcons.kBottomNavBarTransferIcon(
                            colorFilter: bottomNavNotifier.getIndex == 1
                            ? ColorFilter.mode(
                              ColorsCommon.kAccentL2,
                              BlendMode.srcIn,
                            )
                            : Theme.of(context).brightness == Brightness.dark
                              ? ColorFilter.mode(
                                ColorsCommon.kWhite,
                                BlendMode.srcIn,
                              )
                              : null,
                          ),
                          label: AppText.kBottomNavBarTransfer,
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcons.kBottomNavBarPayLoadIcon(
                            colorFilter: bottomNavNotifier.getIndex == 2
                              ? ColorFilter.mode(
                                ColorsCommon.kAccentL2,
                                BlendMode.srcIn,
                              )
                              : Theme.of(context).brightness == Brightness.dark
                                ? ColorFilter.mode(
                                  ColorsCommon.kWhite,
                                  BlendMode.srcIn,
                                )
                                : null,
                          ),
                          label: AppText.kBottomNavBaPayLoad,
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcons.kBottomNavBarInvestIcon(
                            colorFilter: bottomNavNotifier.getIndex == 3
                              ? ColorFilter.mode(
                                ColorsCommon.kAccentL2,
                                BlendMode.srcIn,
                              )
                              : Theme.of(context).brightness == Brightness.dark
                                ? ColorFilter.mode(
                                  ColorsCommon.kWhite,
                                  BlendMode.srcIn,
                                )
                                : null,
                          ),
                          label: AppText.kBottomNavBarInvest,
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcons.kBottomNavBarProfileIcon(
                            colorFilter: bottomNavNotifier.getIndex == 4
                            ? ColorFilter.mode(
                              ColorsCommon.kAccentL2,
                              BlendMode.srcIn,
                            )
                            : Theme.of(context).brightness == Brightness.dark
                              ? ColorFilter.mode(
                                ColorsCommon.kWhite,
                                BlendMode.srcIn,
                              )
                              : null,
                          ),
                          label: AppText.kBottomNavBarProfile,
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ]
          );
        }
      ),
    );
  }
}