import 'package:truth_or_dare/tod/model/model.dart';

abstract class TodState {}

class TodLoadInProgress extends TodState {}

class TodTruthLoadSuccess extends TodState {
  final Truth truth;
  TodTruthLoadSuccess(this.truth);
}

class TodDareLoadSuccess extends TodState {
  final Dare dare;
  TodDareLoadSuccess(this.dare);
}

class TodSyncDataSuccess extends TodState {}
