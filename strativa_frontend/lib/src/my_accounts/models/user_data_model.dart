import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
    User user;
    String firstName;
    String middleName;
    String lastName;
    UserCardDetails userCardDetails;

    UserDataModel({
        required this.user,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.userCardDetails,
    });

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: User.fromJson(json["user"]),
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        userCardDetails: UserCardDetails.fromJson(json["user_card_details"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "user_card_details": userCardDetails.toJson(),
    };
}

class User {
    String username;

    User({
        required this.username,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}

class UserCardDetails {
    String balance;
    String strativaCardNumber;
    DateTime strativaCardCreated;
    DateTime strativaCardExpiry;
    int strativaCardCvv;
    bool isOnlineCardActive;
    String? onlineCardNumber;
    DateTime? onlineCardCreated;
    DateTime? onlineCardExpiry;
    int? onlineCardCvv;

    UserCardDetails({
        required this.balance,
        required this.strativaCardNumber,
        required this.strativaCardCreated,
        required this.strativaCardExpiry,
        required this.strativaCardCvv,
        required this.isOnlineCardActive,
        required this.onlineCardNumber,
        required this.onlineCardCreated,
        required this.onlineCardExpiry,
        required this.onlineCardCvv,
    });

    factory UserCardDetails.fromJson(Map<String, dynamic> json) => UserCardDetails(
        balance: json["balance"],
        strativaCardNumber: json["strativa_card_number"],
        strativaCardCreated: DateTime.parse(json["strativa_card_created"]),
        strativaCardExpiry: DateTime.parse(json["strativa_card_expiry"]),
        strativaCardCvv: json["strativa_card_cvv"],
        isOnlineCardActive: json["is_online_card_active"],
        onlineCardNumber: json["online_card_number"] ?? "",
        onlineCardCreated: json["online_card_created"] != null
          ? DateTime.parse(json["online_card_created"])
          : null,
        onlineCardExpiry: json["online_card_expiry"] != null
          ? DateTime.parse(json["online_card_expiry"])
          : null,
        onlineCardCvv: json["online_card_cvv"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "strativa_card_number": strativaCardNumber,
        "strativa_card_created": strativaCardCreated.toIso8601String(),
        "strativa_card_expiry": strativaCardExpiry.toIso8601String(),
        "strativa_card_cvv": strativaCardCvv,
        "is_online_card_active": isOnlineCardActive,
        "online_card_number": onlineCardNumber,
        "online_card_created": onlineCardCreated?.toIso8601String(),
        "online_card_expiry": onlineCardExpiry?.toIso8601String(),
        "online_card_cvv": onlineCardCvv,
    };
}
