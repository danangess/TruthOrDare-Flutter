import 'package:flutter/cupertino.dart';
import 'package:truth_or_dare/data/model/model.dart';

class Truth extends Model {
  final String category;
  final String text;

  Truth({@required int id, @required this.category, @required this.text})
      : super(id: id);

  factory Truth.fromMap(Map<String, dynamic> data) =>
      Truth(id: data['id'], category: data['category'], text: data['text']);

  @override
  Model fromMap(Map<String, dynamic> data) {
    return Truth(
        id: data['id'], category: data['category'], text: data['text']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "category": this.category,
      "text": this.text,
    };
  }
}
