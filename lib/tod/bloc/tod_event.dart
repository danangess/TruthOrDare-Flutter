import 'package:truth_or_dare/tod/model/model.dart';

abstract class TodEvent {}

class TodStarted extends TodEvent {}

class TodSyncData extends TodEvent {}

class TodTruthChoosed extends TodEvent {}

class TodDareChoosed extends TodEvent {}

class TodTruthSkiped extends TodEvent {
  final Truth truth;
  TodTruthSkiped(this.truth);
}

class TodDareSkiped extends TodEvent {
  final Dare dare;
  TodDareSkiped(this.dare);
}
