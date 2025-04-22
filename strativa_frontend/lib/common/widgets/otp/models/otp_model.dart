import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    String accountNumber;
    String otp;
    String? transactionDetails;

    OtpModel({
        required this.accountNumber,
        required this.otp,
        required this.transactionDetails,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        accountNumber: json["account_number"],
        otp: json["otp"],
        transactionDetails: json["transaction_details"]
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "otp": otp,
        "transaction_details": transactionDetails
    };
}