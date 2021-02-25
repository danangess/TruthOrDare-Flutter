abstract class BaseModel<TKey extends Object> {
  final int id;

  BaseModel({this.id});
}

abstract class Model extends BaseModel<int> {
  Model({int id}) : super(id: id);
  
  Map<String, dynamic> toMap();
  Model fromMap(Map<String, dynamic> data);
}
