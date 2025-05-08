import 'dart:convert';

AccountModalModel accountModalModelFromJson(String str) => AccountModalModel.fromJson(json.decode(str));
String accountModalModelToJson(AccountModalModel data) => json.encode(data.toJson());

UserAccount userAccountFromJson(String str) => UserAccount.fromJson(json.decode(str));
String userAccountToJson(UserAccount data) => json.encode(data.toJson());

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
    Bank bank;
    String accountNumber;
    String balance;

    UserAccount({
        required this.accountType,
        required this.bank,
        required this.accountNumber,
        required this.balance,
    });

    factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        accountType: AccountType.fromJson(json["account_type"]),
        bank: Bank.fromJson(json["bank"]),
        accountNumber: json["account_number"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "account_type": accountType.toJson(),
        "bank": bank.toJson(),
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
