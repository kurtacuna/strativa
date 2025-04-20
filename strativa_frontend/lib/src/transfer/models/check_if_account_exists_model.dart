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