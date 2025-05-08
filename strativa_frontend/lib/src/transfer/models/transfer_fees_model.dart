// To parse this JSON data, do
//
//     final transferFeesModel = transferFeesModelFromJson(jsonString);

import 'dart:convert';

TransferFeesModel transferFeesModelFromJson(String str) => TransferFeesModel.fromJson(json.decode(str));

String transferFeesModelToJson(TransferFeesModel data) => json.encode(data.toJson());

class TransferFeesModel {
    List<Fee> fees;

    TransferFeesModel({
        required this.fees,
    });

    factory TransferFeesModel.fromJson(Map<String, dynamic> json) => TransferFeesModel(
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
