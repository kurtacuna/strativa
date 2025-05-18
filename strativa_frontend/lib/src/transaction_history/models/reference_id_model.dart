import 'dart:convert';

ReferenceIdModel referenceIdModelFromJson(String str) => ReferenceIdModel.fromJson(json.decode(str));

String referenceIdModelToJson(ReferenceIdModel data) => json.encode(data.toJson());

class ReferenceIdModel {
    String referenceId;

    ReferenceIdModel({
        required this.referenceId,
    });

    factory ReferenceIdModel.fromJson(Map<String, dynamic> json) => ReferenceIdModel(
        referenceId: json["reference_id"],
    );

    Map<String, dynamic> toJson() => {
        "reference_id": referenceId,
    };
}