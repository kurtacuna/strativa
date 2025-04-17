import 'dart:convert';

UsernameModel usernameModelFromJson(String str) => UsernameModel.fromJson(json.decode(str));

String usernameModelToJson(UsernameModel data) => json.encode(data.toJson());

class UsernameModel {
    String username;

    UsernameModel({
        required this.username,
    });

    factory UsernameModel.fromJson(Map<String, dynamic> json) => UsernameModel(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}