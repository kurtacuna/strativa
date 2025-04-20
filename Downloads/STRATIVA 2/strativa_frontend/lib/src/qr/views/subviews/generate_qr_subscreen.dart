import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive_widget.dart';

class GenerateQrSubscreen extends StatefulWidget {
  const GenerateQrSubscreen({super.key});

  @override
  State<GenerateQrSubscreen> createState() => _GenerateQrSubscreenState();
}

class _GenerateQrSubscreenState extends State<GenerateQrSubscreen> {
  late final TextEditingController _amountController = TextEditingController();
  final _formKey = AppGlobalKeys.generateQrFormKey;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.kAppPadding,
      child: Column(
        children: [
          // TODO: pass model to this widget
          AppTransferReceiveWidget(),

          SizedBox(height: 50.h),

          Form(
            key: _formKey,
            child: Column(
              children: [
                AppLabeledAmountFieldWidget(
                  text: AppText.kRequestTheAmountOf,
                  controller: _amountController,
                ),

                SizedBox(height: 40.h),

                AppButtonWidget(
                  onTap: () {
                    // if (_formKey.currentState!.validate()) {
                    //   print(_amountController.text);
                    //   context.go(AppRoutes.kGeneratedQrSubscreen);
                    // }
                    context.push(AppRoutes.kGeneratedQrSubscreen);
                  },
                  text: AppText.kGenerateQrCode,
                )
              ]
            ),
          )

        ]
      ),
    );
  }
}