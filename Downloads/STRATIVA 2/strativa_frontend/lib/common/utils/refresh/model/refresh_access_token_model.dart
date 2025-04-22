import 'dart:convert';

RefreshAccessTokenModel refreshAccessTokenModelFromJson(String str) => RefreshAccessTokenModel.fromJson(json.decode(str));

String refreshAccessTokenModelToJson(RefreshAccessTokenModel data) => json.encode(data.toJson());

class RefreshAccessTokenModel {
    String refresh;

    RefreshAccessTokenModel({
        required this.refresh,
    });

    factory RefreshAccessTokenModel.fromJson(Map<String, dynamic> json) => RefreshAccessTokenModel(
        refresh: json["refresh"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
    };
}
