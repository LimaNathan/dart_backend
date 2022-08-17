// ignore_for_file: public_member_api_docs, sort_constructors_first

class ItemModel {
  String? title;
  int? id;
  bool? isActive;

  ItemModel();

  factory ItemModel.fromMap(Map map) => ItemModel()
    ..id = map['id']
    ..title = map['title']
    ..isActive = map['is_active'] == 1;

  Map toJson() => {
        'id': id,
        'title': title,
        'is_active': isActive,
      };

  factory ItemModel.fromRequest(Map map) => ItemModel()
    ..id = map['id']
    ..title = map['title']
    ..isActive = map['is_active'] == 1;

    
  @override
  String toString() => 'ItemModel(title: $title, id: $id, isActive: $isActive)';
}
