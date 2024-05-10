// To parse this JSON data, do
//
//     final userAd = userAdFromJson(jsonString);

import 'dart:convert';

List<UserAd> userAdFromJson(String str) => List<UserAd>.from(json.decode(str).map((x) => UserAd.fromJson(x)));

String userAdToJson(List<UserAd> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAd {
    bool authentication;
    String name;
    String firstName;
    String lastName;
    String email;
    String empId;
    bool locked;
    String samAccount;

    UserAd({
        required this.authentication,
        required this.name,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.empId,
        required this.locked,
        required this.samAccount,
    });

    factory UserAd.fromJson(Map<String, dynamic> json) => UserAd(
        authentication: json["authentication"],
        name: json["name"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        empId: json["empId"],
        locked: json["locked"],
        samAccount: json["samAccount"],
    );

    Map<String, dynamic> toJson() => {
        "authentication": authentication,
        "name": name,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "empId": empId,
        "locked": locked,
        "samAccount": samAccount,
    };
}
