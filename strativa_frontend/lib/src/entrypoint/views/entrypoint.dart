import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
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
                        : const Color.fromARGB(255, 57, 57, 57),
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
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at_circle,
                          ),
                          label: AppText.kBottomNavBarMyAccounts,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at_circle,
                          ),
                          label: AppText.kBottomNavBarTransfer,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at_circle,
                          ),
                          label: AppText.kBottomNavBaPayLoad,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at_circle,
                          ),
                          label: AppText.kBottomNavBarInvest,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Ionicons.at_circle,
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