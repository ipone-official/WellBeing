import 'dart:convert';

List<RankMeRunner> rankMeRunnerFromJson(String str) =>
    List<RankMeRunner>.from(json.decode(str).map((x) => RankMeRunner.fromJson(x)));

String rankMeRunnerToJson(List<RankMeRunner> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RankMeRunner {
  String indexNo;
  String employeeId;
  String sumRecord;
  String employeeNameTh;
  String employeeNameEn;

  RankMeRunner({
    required this.indexNo,
    required this.employeeId,
    required this.sumRecord,
    required this.employeeNameTh,
    required this.employeeNameEn,
  });

  factory RankMeRunner.fromJson(Map<String, dynamic> json) => RankMeRunner(
        indexNo: json["indexNo"],
        employeeId: json["employeeID"],
        sumRecord: json["sumRecord"],
        employeeNameTh: json["employeeNameTH"],
        employeeNameEn: json["employeeNameEN"],
      );

  Map<String, dynamic> toJson() => {
        "indexNo": indexNo,
        "employeeID": employeeId,
        "sumRecord": sumRecord,
        "employeeNameTH": employeeNameTh,
        "employeeNameEN": employeeNameEn,
      };
}
