import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/widgets/otp/controllers/otp_notifier.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/otp_pinput_widget.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/otp_user_id_field_widget.dart';

Future<dynamic> showAppOtpModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => ShowAppOtpModalBottomSheet()
  );
}

class ShowAppOtpModalBottomSheet extends StatefulWidget {
  const ShowAppOtpModalBottomSheet({super.key});

  @override
  State<ShowAppOtpModalBottomSheet> createState() => _ShowAppOtpModalBottomSheetState();
}

class _ShowAppOtpModalBottomSheetState extends State<ShowAppOtpModalBottomSheet> {
  late final TextEditingController _userIdController = TextEditingController();
  final FocusNode _userIdNode = FocusNode();
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
    _userIdController.dispose();
    _userIdNode.dispose();
    _otpNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_userIdNode);
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
                        OtpUserIdFieldWidget(
                          formKey: _formKey,
                          userIdNode: _userIdNode,
                          userIdController: _userIdController
                        ),
                  
                        OtpPinputWidget(
                          otpNode: _otpNode,
                          userIdController: _userIdController
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