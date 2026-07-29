class ApiConstants {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';

  // BCU & Tabela
  static const String bcus = '/bcus';
  static const String tabelas = '/tabelas';

  // Collection
  static const String collection = '/collection';
  static const String dailyCollection = '/collection/daily';

  // Expenses & Categories
  static const String expenses = '/expenses';
  static const String bcuExpenses = '/bcu/expenses';
  static const String tabelaExpenses = '/tabela/expenses';
  static const String homeExpenses = '/home/expenses';

  // Employees
  static const String employees = '/bcu/employees';
  static const String attendance = '/bcu/attendance';
  static const String payroll = '/bcu/payroll';

  // Loans
  static const String loans = '/loans';

  // Rates
  static const String rates = '/rates';

  // Reports
  static const String reports = '/reports';

  // Dashboard
  static const String dashboard = '/dashboard';
}
