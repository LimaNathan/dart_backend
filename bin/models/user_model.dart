// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int id;
  final String name;
  final String email;
  final bool isActived;
  final DateTime dtCreated;
  final DateTime dtUpdated;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActived,
    required this.dtCreated,
    required this.dtUpdated,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['nome'] as String,
      email: map['email'] as String,
      isActived: map['is_ativo'] == 1,
      dtCreated: map['dt_criacao'],
      dtUpdated: map['dt_autalizacao'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
}
