import 'dart:convert';

TransferModel transferModelFromJson(String str) => TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class TransferModel {
    TransactionDetails transactionDetails;

    TransferModel({
        required this.transactionDetails,
    });

    factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        transactionDetails: TransactionDetails.fromJson(json["transaction_details"]),
    );

    Map<String, dynamic> toJson() => {
        "transaction_details": transactionDetails.toJson(),
    };
}

class TransactionDetails {
    String transactionType;
    String amount;
    String note;
    User sender;
    User receiver;

    TransactionDetails({
        required this.transactionType,
        required this.amount,
        required this.note,
        required this.sender,
        required this.receiver,
    });

    factory TransactionDetails.fromJson(Map<String, dynamic> json) => TransactionDetails(
        transactionType: json["transaction_type"],
        amount: json["amount"],
        note: json["note"],
        sender: User.fromJson(json["sender"]),
        receiver: User.fromJson(json["receiver"]),
    );

    Map<String, dynamic> toJson() => {
        "transaction_type": transactionType,
        "amount": amount,
        "note": note,
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
    };
}

class User {
    String accountNumber;
    String bank;

    User({
        required this.accountNumber,
        required this.bank,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        accountNumber: json["account_number"],
        bank: json["bank"]
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "bank": bank
    };
}