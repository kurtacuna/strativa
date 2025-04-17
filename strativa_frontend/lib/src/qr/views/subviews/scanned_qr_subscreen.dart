import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_note_field_widget.dart';
import 'package:strativa_frontend/src/qr/controllers/scan_qr_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/scanned_qr_details_widget.dart';

class ScannedQrSubscreen extends StatelessWidget {
  const ScannedQrSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = AppGlobalKeys.scannedQrFormKey;
    TextEditingController amountController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    String scannedQrData = context.read<ScanQrNotifier>().getScannedQrData;
    List dataSplit = scannedQrData.split(', ');

    void navigator() {
      context.read<ScanQrNotifier>().getScannerController.start();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder:(context) {
            return IconButton(
              onPressed: () {
                navigator();
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
              ScannedQrDetailsWidget(
                fullName: dataSplit[0].toUpperCase(),
                type: dataSplit[1],
                accountNumber: dataSplit[2],
                amountRequested: dataSplit[3]
              ),

              SizedBox(height: 50.h),

              // Labeled Amount with Note Fields
              dataSplit[3] == ""
                ? Column(
                  children: [
                    Form(
                      key: formKey,
                      child: AppLabeledAmountNoteFieldWidget(
                        text: AppText.kTransferTheAmountOf,
                        amountController: amountController,
                        addNote: true,
                        addNoteController: noteController
                      )
                    ),

                    SizedBox(height: 40.h)
                  ],
                )
                : Container(),

              AppButtonWidget(
                onTap: () {
                  // TODO: handle transaction
                  print("tapped");
                }, 
                text: AppText.kConfirm
              ),

              SizedBox(height: 5.h),

              AppButtonWidget(
                onTap: () {
                  navigator();
                },
                text: AppText.kCancel,
                color: ColorsCommon.kPrimaryL3,
                showBorder: true,
                firstColor: Colors.transparent,
                secondColor: Colors.transparent,
              ),
            ]
          )
        )
      )
    );
  }
}