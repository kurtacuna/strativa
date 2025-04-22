import 'dart:convert';

PeekBalanceModel peekBalanceModelFromJson(String str) => PeekBalanceModel.fromJson(json.decode(str));

String peekBalanceModelToJson(PeekBalanceModel data) => json.encode(data.toJson());

class PeekBalanceModel {
    String balance;

    PeekBalanceModel({
        required this.balance,
    });

    factory PeekBalanceModel.fromJson(Map<String, dynamic> json) => PeekBalanceModel(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}