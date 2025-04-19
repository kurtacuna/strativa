import 'dart:convert';

AccountModalModel accountModalModelFromJson(String str) => AccountModalModel.fromJson(json.decode(str));

String accountModalModelToJson(AccountModalModel data) => json.encode(data.toJson());

class AccountModalModel {
    List<UserAccount> userAccounts;

    AccountModalModel({
        required this.userAccounts,
    });

    factory AccountModalModel.fromJson(Map<String, dynamic> json) => AccountModalModel(
        userAccounts: List<UserAccount>.from(json["user_accounts"].map((x) => UserAccount.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user_accounts": List<dynamic>.from(userAccounts.map((x) => x.toJson())),
    };
}

class UserAccount {
    AccountType accountType;
    String accountNumber;
    String balance;

    UserAccount({
        required this.accountType,
        required this.accountNumber,
        required this.balance,
    });

    factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        accountType: AccountType.fromJson(json["account_type"]),
        accountNumber: json["account_number"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "account_type": accountType.toJson(),
        "account_number": accountNumber,
        "balance": balance,
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