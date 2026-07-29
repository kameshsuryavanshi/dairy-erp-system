class TabelaModel {
  final int id;
  final int bcuId;
  final String code;
  final String name;
  final String ownerName;
  final String? mobile;
  final String? village;
  final int totalBuffalo;
  final int totalCow;

  TabelaModel({
    required this.id,
    required this.bcuId,
    required this.code,
    required this.name,
    required this.ownerName,
    this.mobile,
    this.village,
    this.totalBuffalo = 0,
    this.totalCow = 0,
  });

  factory TabelaModel.fromJson(Map<String, dynamic> json) {
    return TabelaModel(
      id: json['id'],
      bcuId: json['bcu_id'],
      code: json['code'],
      name: json['name'],
      ownerName: json['owner_name'],
      mobile: json['mobile'],
      village: json['village'],
      totalBuffalo: json['total_buffalo'] ?? 0,
      totalCow: json['total_cow'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bcu_id': bcuId,
      'code': code,
      'name': name,
      'owner_name': ownerName,
      'mobile': mobile,
      'village': village,
      'total_buffalo': totalBuffalo,
      'total_cow': totalCow,
    };
  }
}
