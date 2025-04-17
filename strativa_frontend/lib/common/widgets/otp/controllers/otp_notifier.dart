import 'dart:async';
import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';

class OtpNotifier with ChangeNotifier {
  int _duration = AppConstants.kOtpResendDuration;
  bool _isDisabled = false;
  bool _isPinputEnabled = false;
  bool _widgetIsBeingDisposed = false;
  bool _isLoading = false;

  get getDuration => _duration;
  get getIsDisabled => _isDisabled;
  get getIsPinputEnabled => _isPinputEnabled;
  get getIsLoading => _isLoading;

  void toggleButtonState() {
    _isDisabled =! _isDisabled;
    notifyListeners();
  }

  set setIsPinputEnabled(bool state) {
    _isPinputEnabled = state;
    if (!_widgetIsBeingDisposed) {
      notifyListeners();
    } else {
      _widgetIsBeingDisposed = false;
    }
  }

  set setWidgetIsBeingDisposed(bool state) {
    _widgetIsBeingDisposed = state;
  }

  void startTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_duration == 0) {
          toggleButtonState();
          timer.cancel();
          _duration = AppConstants.kOtpResendDuration;
        } else {
          _duration--;
        }

        notifyListeners();
      },
    );
  }

  Future<void> sendOtp({
    required BuildContext context,
    required String data,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      var url = Uri.parse(ApiUrls.createOtpUrl);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: data
      );

      if (response.statusCode == 200) {
        toggleButtonState();
        startTimer();
        _isPinputEnabled = true;
      } else {
        if (context.mounted) {
          CommonJsonModel model = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBarWidget(
              context: context,
              text: model.detail,
              icon: AppIcons.kErrorIcon
            )
          );
        }
      }

    } catch (e) {
      print("OtpNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> validateOtp({
    required BuildContext context, 
    required String data,
    required String query,
  }) async {
    _isPinputEnabled = false;
    notifyListeners();
    
    try {
      var url = Uri.parse(ApiUrls.verifyOtpUrl(query: query));
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: data
      );

      CommonJsonModel model = commonJsonModelFromJson(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBarWidget(
              context: context,
              text: model.detail,
              style: CustomTextStyles(context).biggestStyle,
              icon: SizedBox.shrink(),
              duration: query == "peekbalance" ? Duration(seconds: 60) : null
            )
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBarWidget(
              context: context, 
              text: model.detail,
              icon: AppIcons.kErrorIcon
            )
          );
        }
      }


    } catch (e) {
      print("OtpNotifier:");
      print(e);
    } finally {
      _isPinputEnabled = true;
      notifyListeners();
    }
  }

}