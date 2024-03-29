import 'package:equatable/equatable.dart';

import '../../Pages/models/rank_me_runner .dart';

enum FetchRecordMeStatus { fetching, success, failed, init }

class RecordMeState extends Equatable {
  const RecordMeState(
      {this.rankMeRunner = const [],
      this.status = FetchRecordMeStatus.init});

  final List<RankMeRunner> rankMeRunner;
  final FetchRecordMeStatus status;

  RecordMeState copywith({List<RankMeRunner>? rankMeRunner, FetchRecordMeStatus? status}) {
    return RecordMeState(
        rankMeRunner: rankMeRunner ?? this.rankMeRunner,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        rankMeRunner,
        status,
      ];
}
