class BCUModel {
  final int id;
  final String code;
  final String name;
  final String? location;
  final bool isActive;

  BCUModel({
    required this.id,
    required this.code,
    required this.name,
    this.location,
    this.isActive = true,
  });

  factory BCUModel.fromJson(Map<String, dynamic> json) {
    return BCUModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      location: json['location'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'location': location,
      'is_active': isActive,
    };
  }
}
