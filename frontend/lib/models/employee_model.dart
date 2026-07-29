class EmployeeModel {
  final int id;
  final int bcuId;
  final String name;
  final String role;
  final double salary;
  final String? mobile;
  final String joiningDate;
  final bool isActive;

  EmployeeModel({
    required this.id,
    required this.bcuId,
    required this.name,
    required this.role,
    required this.salary,
    this.mobile,
    required this.joiningDate,
    this.isActive = true,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      bcuId: json['bcu_id'],
      name: json['name'],
      role: json['role'],
      salary: (json['salary'] as num).toDouble(),
      mobile: json['mobile'],
      joiningDate: json['joining_date'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bcu_id': bcuId,
      'name': name,
      'role': role,
      'salary': salary,
      'mobile': mobile,
      'joining_date': joiningDate,
      'is_active': isActive,
    };
  }
}
