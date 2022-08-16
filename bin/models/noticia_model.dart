// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  int? id;
  String? title;
  String? description;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  int? userID;

  NoticiaModel();

  factory NoticiaModel.fromMap(Map map) {
    return NoticiaModel()
      ..id = map["id"]
      ..title = map["titulo"]
      ..description = map['descricao'].toString()
      ..dtCreated = map['dt_criacao']
      ..dtUpdated = map['dt_atualizacao']
      ..userID = map['id_usuario']?.toInt();
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory NoticiaModel.fromRequest(Map map) {
    return NoticiaModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..userID = map['userID']?.toInt();
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, title: $title, description: $description, dtCreated: $dtCreated, dtUpdated: $dtUpdated, userID: $userID)';
  }
}
