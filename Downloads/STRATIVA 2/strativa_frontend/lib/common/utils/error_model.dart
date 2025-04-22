import 'dart:convert';

JsonErrorModel jsonErrorModelFromJson(String str) => JsonErrorModel.fromJson(json.decode(str));

String jsonErrorModelToJson(JsonErrorModel data) => json.encode(data.toJson());

class JsonErrorModel {
    String detail;

    JsonErrorModel({
        required this.detail,
    });

    factory JsonErrorModel.fromJson(Map<String, dynamic> json) => JsonErrorModel(
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
    };
}
