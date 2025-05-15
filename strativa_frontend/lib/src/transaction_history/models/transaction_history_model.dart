import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
    List<TransactionElement> transactions;

    TransactionHistoryModel({
        required this.transactions,
    });

    factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
        transactions: List<TransactionElement>.from(json["transactions"].map((x) => TransactionElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    };
}

class TransactionElement {
    TransactionTransaction transaction;
    String direction;
    String resultingBalance;

    TransactionElement({
        required this.transaction,
        required this.direction,
        required this.resultingBalance,
    });

    factory TransactionElement.fromJson(Map<String, dynamic> json) => TransactionElement(
        transaction: TransactionTransaction.fromJson(json["transaction"]),
        direction: json["direction"],
        resultingBalance: json["resulting_balance"],
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "direction": direction,
        "resulting_balance": resultingBalance,
    };
}

class TransactionTransaction {
    TransactionType transactionType;
    Receiver sender;
    String senderAccountNumber;
    Receiver receiver;
    String receiverAccountNumber;
    String referenceId;
    DateTime datetime;
    String amount;
    String? note;

    TransactionTransaction({
        required this.transactionType,
        required this.sender,
        required this.senderAccountNumber,
        required this.receiver,
        required this.receiverAccountNumber,
        required this.referenceId,
        required this.datetime,
        required this.amount,
        this.note = "",
    });

    factory TransactionTransaction.fromJson(Map<String, dynamic> json) => TransactionTransaction(
        transactionType: TransactionType.fromJson(json["transaction_type"]),
        sender: Receiver.fromJson(json["sender"]),
        senderAccountNumber: json["sender_account_number"],
        receiver: Receiver.fromJson(json["receiver"]),
        receiverAccountNumber: json["receiver_account_number"],
        referenceId: json["reference_id"],
        datetime: DateTime.parse(json["datetime"]),
        amount: json["amount"],
        note: json["note"]
    );

    Map<String, dynamic> toJson() => {
        "transaction_type": transactionType.toJson(),
        "sender": sender.toJson(),
        "sender_account_number": senderAccountNumber,
        "receiver": receiver.toJson(),
        "receiver_account_number": receiverAccountNumber,
        "reference_id": referenceId,
        "datetime": datetime.toIso8601String(),
        "amount": amount,
        "note": note
    };
}

class Receiver {
    String username;
    String fullName;
    String profilePicture;

    Receiver({
        required this.username,
        required this.fullName,
        required this.profilePicture,
    });

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        username: json["username"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": fullName,
        "profile_picture": profilePicture,
    };
}

class TransactionType {
    String type;

    TransactionType({
        required this.type,
    });

    factory TransactionType.fromJson(Map<String, dynamic> json) => TransactionType(
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
    };
}
