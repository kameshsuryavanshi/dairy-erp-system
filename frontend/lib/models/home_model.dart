class HomeExpenseModel {
  final int id;
  final int categoryId;
  final String? category;
  final String date;
  final double amount;
  final String? description;
  final String? personName;

  HomeExpenseModel({
    required this.id,
    required this.categoryId,
    this.category,
    required this.date,
    required this.amount,
    this.description,
    this.personName,
  });

  factory HomeExpenseModel.fromJson(Map<String, dynamic> json) {
    return HomeExpenseModel(
      id: json['id'],
      categoryId: json['category_id'],
      category: json['category'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      personName: json['person_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'category': category,
      'date': date,
      'amount': amount,
      'description': description,
      'person_name': personName,
    };
  }
}
