class NoticiaModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime dtPub;
  final DateTime? dtAtt;

  NoticiaModel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.dtPub,
    this.dtAtt,
  );

  factory NoticiaModel.fromJson(Map map) {
    return NoticiaModel(
      map['id'] ?? "",
      map['title'],
      map['description'],
      map['image'],
      DateTime.fromMicrosecondsSinceEpoch((map["dtPub"])),
      map['dtAtt'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(int.parse(map["dtAtt"]))
          : null,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
