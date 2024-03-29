import 'dart:convert';

List<RankRunner> rankRunnerFromJson(String str) =>
    List<RankRunner>.from(json.decode(str).map((x) => RankRunner.fromJson(x)));

String rankRunnerToJson(List<RankRunner> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RankRunner {
  String indexNo;
  String employeeId;
  String sumRecord;
  String employeeNameTh;
  String employeeNameEn;

  RankRunner({
    required this.indexNo,
    required this.employeeId,
    required this.sumRecord,
    required this.employeeNameTh,
    required this.employeeNameEn,
  });

  factory RankRunner.fromJson(Map<String, dynamic> json) => RankRunner(
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
