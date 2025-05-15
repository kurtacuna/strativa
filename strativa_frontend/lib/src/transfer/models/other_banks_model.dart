import 'dart:convert';

List<OtherBanksModel> otherBanksModelFromJson(String str) => List<OtherBanksModel>.from(json.decode(str).map((x) => OtherBanksModel.fromJson(x)));

String otherBanksModelToJson(List<OtherBanksModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherBanksModel {
    String bankName;

    OtherBanksModel({
        required this.bankName,
    });

    factory OtherBanksModel.fromJson(Map<String, dynamic> json) => OtherBanksModel(
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "bank_name": bankName,
    };
}