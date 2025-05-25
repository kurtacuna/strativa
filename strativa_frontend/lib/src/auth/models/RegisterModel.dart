// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String firstName;
    String middleName;
    String lastName;
    String email;
    String phoneNumber;
    String dateOfBirth;
    String cityOfBirth;
    String idImagePath;
    String selfieImagePath;
    String gender;
    String maritalStatus;
    String region;
    String province;
    String municipality;
    String barangay;
    String unit;
    String street;

    RegisterModel({
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.dateOfBirth,
        required this.cityOfBirth,
        required this.idImagePath,
        required this.selfieImagePath,
        required this.gender,
        required this.maritalStatus,
        required this.region,
        required this.province,
        required this.municipality,
        required this.barangay,
        required this.unit,
        required this.street,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        dateOfBirth: json["date_of_birth"],
        cityOfBirth: json["city_of_birth"],
        idImagePath: json["id_image_path"],
        selfieImagePath: json["selfie_image_path"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        region: json["region"],
        province: json["province"],
        municipality: json["municipality"],
        barangay: json["barangay"],
        unit: json["unit"],
        street: json["street"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "date_of_birth": dateOfBirth,
        "city_of_birth": cityOfBirth,
        "id_image_path": idImagePath,
        "selfie_image_path": selfieImagePath,
        "gender": gender,
        "marital_status": maritalStatus,
        "region": region,
        "province": province,
        "municipality": municipality,
        "barangay": barangay,
        "unit": unit,
        "street": street,
    };
}
