// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    String employeeId;
    String employeeNameTh;
    String employeeNameEn;

    Users({
        required this.employeeId,
        required this.employeeNameTh,
        required this.employeeNameEn,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        employeeId: json["employee_ID"],
        employeeNameTh: json["employeeName_TH"],
        employeeNameEn: json["employeeName_EN"],
    );

    Map<String, dynamic> toJson() => {
        "employee_ID": employeeId,
        "employeeName_TH": employeeNameTh,
        "employeeName_EN": employeeNameEn,
    };
}
