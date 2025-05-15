import 'dart:convert';

CheckIfOtherBankAccountExistsModel checkIfOtherBankAccountExistsModelFromJson(String str) => CheckIfOtherBankAccountExistsModel.fromJson(json.decode(str));

String checkIfOtherBankAccountExistsModelToJson(CheckIfOtherBankAccountExistsModel data) => json.encode(data.toJson());

class CheckIfOtherBankAccountExistsModel {
    OtherBankAccountDetails otherBankAccountDetails;

    CheckIfOtherBankAccountExistsModel({
        required this.otherBankAccountDetails,
    });

    factory CheckIfOtherBankAccountExistsModel.fromJson(Map<String, dynamic> json) => CheckIfOtherBankAccountExistsModel(
        otherBankAccountDetails: OtherBankAccountDetails.fromJson(json["other_bank_account_details"]),
    );

    Map<String, dynamic> toJson() => {
        "other_bank_account_details": otherBankAccountDetails.toJson(),
    };
}

class OtherBankAccountDetails {
    String bank;
    String accountNumber;
    String fullName;

    OtherBankAccountDetails({
        required this.bank,
        required this.accountNumber,
        required this.fullName,
    });

    factory OtherBankAccountDetails.fromJson(Map<String, dynamic> json) => OtherBankAccountDetails(
        bank: json["bank"],
        accountNumber: json["account_number"],
        fullName: json["full_name"],
    );

    Map<String, dynamic> toJson() => {
        "bank": bank,
        "account_number": accountNumber,
        "full_name": fullName,
    };
}