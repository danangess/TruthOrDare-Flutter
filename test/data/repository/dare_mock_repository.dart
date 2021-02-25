import 'dart:math';
import 'package:truth_or_dare/tod/model/model.dart';

import 'mock_repository.dart';

class DareMockRepository extends MockRepository<Dare> {
  @override
  Future<Dare> fetchRandom() async {
    var index = new Random().nextInt(MockRepository.database.length);
    return MockRepository.database.values.elementAt(index);
  }
}
