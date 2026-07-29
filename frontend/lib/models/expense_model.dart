class ExpenseModel {
  final int id;
  final int categoryId;
  final String? category;
  final String date;
  final double amount;
  final String? description;
  final String? invoiceNo;
  final bool deductFromIncome;

  ExpenseModel({
    required this.id,
    required this.categoryId,
    this.category,
    required this.date,
    required this.amount,
    this.description,
    this.invoiceNo,
    this.deductFromIncome = true,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      categoryId: json['category_id'],
      category: json['category'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      invoiceNo: json['invoice_no'],
      deductFromIncome: json['deduct_from_income'] == 1 || json['deduct_from_income'] == true,
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
      'invoice_no': invoiceNo,
      'deduct_from_income': deductFromIncome,
    };
  }
}
