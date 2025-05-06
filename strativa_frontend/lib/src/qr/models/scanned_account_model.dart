import 'dart:convert';

ScannedAccountModel scannedAccountModelFromJson(String str) => ScannedAccountModel.fromJson(json.decode(str));

String scannedAccountModelToJson(ScannedAccountModel data) => json.encode(data.toJson());

class ScannedAccountModel {
    String fullname;
    String accountType;
    String accountNumber;
    String bank;
    String amountRequested;

    ScannedAccountModel({
        required this.fullname,
        required this.accountType,
        required this.accountNumber,
        required this.bank,
        required this.amountRequested,
    });

    factory ScannedAccountModel.fromJson(Map<String, dynamic> json) => ScannedAccountModel(
        fullname: json["fullname"],
        accountType: json["account_type"],
        accountNumber: json["account_number"],
        bank: json["bank"],
        amountRequested: json["amount_requested"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "account_type": accountType,
        "account_number": accountNumber,
        "bank": bank,
        "amount_requested": amountRequested,
    };
}
