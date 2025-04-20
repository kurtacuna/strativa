import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/widgets/otp/controllers/otp_notifier.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/otp_pinput_widget.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/otp_account_number_field_widget.dart';

Future<dynamic> showAppOtpModalBottomSheet({
  required BuildContext context,
  String? query,
  String? initialValue,
  bool? sendOtp,
  String? transactionDetails
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => ShowAppOtpModalBottomSheet(
      query: query,
      initialValue: initialValue,
      sendOtp: sendOtp,
      transactionDetails: transactionDetails
    )
  );
}

class ShowAppOtpModalBottomSheet extends StatefulWidget {
  const ShowAppOtpModalBottomSheet({
    this.query,
    this.initialValue,
    this.sendOtp,
    this.transactionDetails,
    super.key
  });

  final String? query;
  final String? initialValue;
  final bool? sendOtp;
  final String? transactionDetails;

  @override
  State<ShowAppOtpModalBottomSheet> createState() => _ShowAppOtpModalBottomSheetState();
}

class _ShowAppOtpModalBottomSheetState extends State<ShowAppOtpModalBottomSheet> {
  late final TextEditingController _accountNumberController = TextEditingController();
  final FocusNode _accountNumberNode = FocusNode();
  final FocusNode _otpNode = FocusNode();
  final _formKey = AppGlobalKeys.otpFormKey;
  OtpNotifier? notifier;

  @override
  void initState() {
    notifier = Provider.of<OtpNotifier>(context, listen: false);
    super.initState();
  }
  
  @override
  void dispose() {
    notifier!.setWidgetIsBeingDisposed = true;
    notifier!.setIsPinputEnabled = false;
    _accountNumberController.dispose();
    _accountNumberNode.dispose();
    _otpNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_accountNumberNode);
    return SingleChildScrollView(
      child: Consumer<OtpNotifier>(
        builder:(context, otpNotifier, child) {
          return SizedBox(
            width: ScreenUtil().screenWidth,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: AppConstants.kAppPadding,
                    child: Column(
                      spacing: 5,
                      children: [
                        OtpAccountNumberFieldWidget(
                          formKey: _formKey,
                          accountNumberNode: _accountNumberNode,
                          accountNumberController: _accountNumberController,
                          initialValue: widget.initialValue,
                          sendOtp: widget.sendOtp
                        ),
                  
                        OtpPinputWidget(
                          otpNode: _otpNode,
                          accountNumberController: _accountNumberController,
                          query: widget.query,
                          transactionDetails: widget.transactionDetails,
                        )
                      ],
                    ),
                  )
                ),
              ]
            )
          );
        },
      )
    );
  }
}