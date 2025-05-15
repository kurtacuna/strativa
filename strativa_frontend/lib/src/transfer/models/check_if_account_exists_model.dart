import 'dart:convert';

CheckIfAccountExists checkIfAccountExistsFromJson(String str) => CheckIfAccountExists.fromJson(json.decode(str));

String checkIfAccountExistsToJson(CheckIfAccountExists data) => json.encode(data.toJson());

class CheckIfAccountExists {
    String accountNumber;

    CheckIfAccountExists({
        required this.accountNumber,
    });

    factory CheckIfAccountExists.fromJson(Map<String, dynamic> json) => CheckIfAccountExists(
        accountNumber: json["account_number"],
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
    };
}

CheckedAccountModel checkedAccountModelFromJson(String str) => CheckedAccountModel.fromJson(json.decode(str));

String checkedAccountModelToJson(CheckedAccountModel data) => json.encode(data.toJson());

class CheckedAccountModel {
    AccountType accountType;
    Bank bank;
    String accountNumber;

    CheckedAccountModel({
        required this.accountType,
        required this.bank,
        required this.accountNumber,
    });

    factory CheckedAccountModel.fromJson(Map<String, dynamic> json) => CheckedAccountModel(
        accountType: AccountType.fromJson(json["account_type"]),
        bank: Bank.fromJson(json["bank"]),
        accountNumber: json["account_number"],
    );

    Map<String, dynamic> toJson() => {
        "account_type": accountType.toJson(),
        "bank": bank.toJson(),
        "account_number": accountNumber,
    };
}

class AccountType {
    String accountType;

    AccountType({
        required this.accountType,
    });

    factory AccountType.fromJson(Map<String, dynamic> json) => AccountType(
        accountType: json["account_type"],
    );

    Map<String, dynamic> toJson() => {
        "account_type": accountType,
    };
}

class Bank {
    String bankName;

    Bank({
        required this.bankName,
    });

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "bank_name": bankName,
    };
}