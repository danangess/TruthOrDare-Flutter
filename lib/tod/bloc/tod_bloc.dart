import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:truth_or_dare/data/repository/repository.dart';
import 'package:truth_or_dare/tod/data/database/database.dart';
import 'package:truth_or_dare/tod/model/model.dart';
import 'package:truth_or_dare/util/util.dart';

import 'bloc.dart';

class TodBloc extends Bloc<TodEvent, TodState> {
  final BaseRepository<Truth> truthRepository = SqliteRepository(
    database: DatabaseProvider.dbProvider.database,
    tableName: TRUTH_TABLE,
    fromMap: (data) => Truth.fromMap(data),
  );
  final BaseRepository<Dare> dareRepository = SqliteRepository(
    database: DatabaseProvider.dbProvider.database,
    tableName: DARE_TABLE,
    fromMap: (data) => Dare.fromMap(data),
  );

  TodBloc() : super(TodLoadInProgress());

  @override
  Stream<TodState> mapEventToState(TodEvent event) async* {
    if (event is TodSyncData) {
      yield* _mapTodSyncDataToState(event);
    } else if (event is TodTruthChoosed) {
      yield* _mapTodTruthChoosedToState(event);
    } else if (event is TodDareChoosed) {
      yield* _mapTodDareChoosedToState(event);
    }
  }

  Stream<TodState> _mapTodSyncDataToState(TodSyncData event) async* {
    var seeder = Seeder("assets/seed/dare.json", dareRepository);
    await seeder.seed();
    yield TodSyncDataSuccess();
  }

  Stream<TodState> _mapTodTruthChoosedToState(TodTruthChoosed event) async* {
    var truth = await this.truthRepository.fetchRandom();
    yield TodTruthLoadSuccess(truth);
  }

  Stream<TodState> _mapTodDareChoosedToState(TodDareChoosed event) async* {
    var dare = await this.dareRepository.fetchRandom();
    yield TodDareLoadSuccess(dare);
  }

  dispose() {
    truthRepository.dispose();
    dareRepository.dispose();
  }
}
