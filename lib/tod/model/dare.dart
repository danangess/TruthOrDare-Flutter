import 'package:flutter/cupertino.dart';
import 'package:truth_or_dare/data/model/model.dart';

class Dare extends Model {
  final String category;
  final String text;

  Dare({@required int id, @required this.category, @required this.text})
      : super(id: id);

  factory Dare.fromMap(Map<String, dynamic> data) =>
      Dare(id: data['id'], category: data['category'], text: data['text']);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "category": this.category,
      "text": this.text,
    };
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    return Dare(id: data['id'], category: data['category'], text: data['text']);
  }
}
