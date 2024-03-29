// To parse this JSON data, do
//
//     final historyRunner = historyRunnerFromJson(jsonString);

import 'dart:convert';

List<HistoryRunner> historyRunnerFromJson(String str) => List<HistoryRunner>.from(json.decode(str).map((x) => HistoryRunner.fromJson(x)));

String historyRunnerToJson(List<HistoryRunner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryRunner {
    String recordDate;
    String record;

    HistoryRunner({
        required this.recordDate,
        required this.record,
    });

    factory HistoryRunner.fromJson(Map<String, dynamic> json) => HistoryRunner(
        recordDate: json["recordDate"],
        record: json["record"],
    );

    Map<String, dynamic> toJson() => {
        "recordDate": recordDate,
        "record": record,
    };
}
