class LoanModel {
  final int id;
  final String name;
  final String lender;
  final String borrower;
  final double baseAmount;
  final double monthlyInterest;
  final double monthlyEmi;
  final String loanDate;
  final double remainingBalance;
  final String status;

  LoanModel({
    required this.id,
    required this.name,
    required this.lender,
    required this.borrower,
    required this.baseAmount,
    required this.monthlyInterest,
    required this.monthlyEmi,
    required this.loanDate,
    required this.remainingBalance,
    this.status = 'active',
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      name: json['name'],
      lender: json['lender'],
      borrower: json['borrower'],
      baseAmount: (json['base_amount'] as num).toDouble(),
      monthlyInterest: (json['monthly_interest'] as num).toDouble(),
      monthlyEmi: (json['monthly_emi'] as num).toDouble(),
      loanDate: json['loan_date'],
      remainingBalance: (json['remaining_balance'] as num).toDouble(),
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lender': lender,
      'borrower': borrower,
      'base_amount': baseAmount,
      'monthly_interest': monthlyInterest,
      'monthly_emi': monthlyEmi,
      'loan_date': loanDate,
      'remaining_balance': remainingBalance,
      'status': status,
    };
  }
}
