import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/rank_runner.dart';

enum FetchStatus { fetching, success, failed, init }

class RecordState extends Equatable {
  const RecordState(
      {this.rankRunner = const [],
      this.status = FetchStatus.init});

  final List<RankRunner> rankRunner;
  final FetchStatus status;

  RecordState copywith({List<RankRunner>? rankRunner, FetchStatus? status}) {
    return RecordState(
        rankRunner: rankRunner ?? this.rankRunner,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        rankRunner,
        status,
      ];
}
