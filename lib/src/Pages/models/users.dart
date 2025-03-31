// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

class Users {
  final String employeeId;
  final String employeeNameTh;
  final String employeeNameEn;

  Users({
    required this.employeeId,
    required this.employeeNameTh,
    required this.employeeNameEn,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      employeeId: json['employee_ID'] ?? '',
      employeeNameTh: json['employeeName_TH'] ?? '',
      employeeNameEn: json['employeeName_EN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_ID': employeeId,
      'employeeName_TH': employeeNameTh,
      'employeeName_EN': employeeNameEn,
    };
  }
}