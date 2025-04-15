import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    String username;
    String otp;

    OtpModel({
        required this.username,
        required this.otp,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        username: json["username"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "otp": otp,
    };
}