import 'dart:convert';

AccountNumber accountNumberFromJson(String str) => AccountNumber.fromJson(json.decode(str));

String accountNumberToJson(AccountNumber data) => json.encode(data.toJson());

class AccountNumber {
    String accountNumber;

    AccountNumber({
        required this.accountNumber,
    });

    factory AccountNumber.fromJson(Map<String, dynamic> json) => AccountNumber(
        accountNumber: json["account_number"],
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
    };
}
