class UserModel {
  int? id;
  String? name;

  String? password;
  bool? isActived;

  UserModel();
  UserModel.create({
    required this.id,
    required this.name,
    required this.isActived,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      id: map['id'] as int,
      name: map['name'] as String,
      isActived: map['is_active'] == 1,
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id']?.toInt()
      ..password = map['password'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..password = map['password']
      ..isActived = map['is_active'] == 1;
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'is_active': isActived,
      };

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, isActived: $isActived)';
  }
}
