import '../api/api.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UserModel();
  UserModel.create({
    required this.id,
    required this.name,
    required this.email,
    required this.isActived,
    required this.dtCreated,
    required this.dtUpdated,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      id: map['id'] as int,
      name: map['nome'] as String,
      email: map['email'] as String,
      isActived: map['is_ativo'] == 1,
      dtCreated: map['dt_criacao'],
      dtUpdated: map['dt_autalizacao'],
    );
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
}
