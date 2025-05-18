// To parse this JSON data, do
//
//     final transferFeesModel = transferFeesModelFromJson(jsonString);

import 'dart:convert';

TransactionFeesModel transactionFeesModelFromJson(String str) => TransactionFeesModel.fromJson(json.decode(str));

String transactionFeesModelToJson(TransactionFeesModel data) => json.encode(data.toJson());

class TransactionFeesModel {
  List<Fee> fees;

  TransactionFeesModel({
    required this.fees,
  });

  factory TransactionFeesModel.fromJson(Map<String, dynamic> json) => TransactionFeesModel(
    fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fees": List<dynamic>.from(fees.map((x) => x.toJson())),
  };
}

class Fee {
  String type;
  String fee;

  Fee({
    required this.type,
    required this.fee,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    type: json["type"],
    fee: json["fee"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "fee": fee,
  };
}