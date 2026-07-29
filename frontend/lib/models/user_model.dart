class UserModel {
  final int id;
  final String name;
  final String role;
  final int? bcuId;
  final int? tabelaId;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    this.bcuId,
    this.tabelaId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? json['full_name'] ?? '',
      role: json['role'] ?? '',
      bcuId: json['bcu_id'],
      tabelaId: json['tabela_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'bcu_id': bcuId,
      'tabela_id': tabelaId,
    };
  }
}
