// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:dairy_erp/features/auth/presentation/login_screen.dart';
// import 'package:dairy_erp/features/auth/presentation/splash_screen.dart';
// import 'package:dairy_erp/features/dashboard/presentation/admin_dashboard.dart';
// import 'package:dairy_erp/features/dashboard/presentation/bcu_dashboard.dart';
// import 'package:dairy_erp/features/dashboard/presentation/tabela_dashboard.dart';
// import 'package:dairy_erp/features/collection/presentation/collection_screen.dart';
// import 'package:dairy_erp/features/collection/presentation/collection_history.dart';
// import 'package:dairy_erp/features/collection/presentation/collection_report.dart';
// import 'package:dairy_erp/features/expenses/presentation/bcu_expense_screen.dart';
// import 'package:dairy_erp/features/expenses/presentation/tabela_expense_screen.dart';
// import 'package:dairy_erp/features/expenses/presentation/home_expense_screen.dart';
// import 'package:dairy_erp/features/employees/presentation/employee_list_screen.dart';
// import 'package:dairy_erp/features/employees/presentation/attendance_screen.dart';
// import 'package:dairy_erp/features/employees/presentation/payroll_screen.dart';
// import 'package:dairy_erp/features/loans/presentation/loan_list_screen.dart';
// import 'package:dairy_erp/features/rates/presentation/rate_config_screen.dart';
// import 'package:dairy_erp/features/reports/presentation/report_screen.dart';

// final GoRouter appRouter = GoRouter(
//   initialLocation: '/',
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: '/admin-dashboard',
//       builder: (BuildContext context, GoRouterState state) => const AdminDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/bcu-dashboard',
//       builder: (BuildContext context, GoRouterState state) => const BCUDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/tabela-dashboard',
//       builder: (BuildContext context, GoRouterState state) => const TabelaDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/collection',
//       builder: (BuildContext context, GoRouterState state) => const CollectionScreen(),
//     ),
//     GoRoute(
//       path: '/collection-history',
//       builder: (BuildContext context, GoRouterState state) => const CollectionHistoryScreen(),
//     ),
//     GoRoute(
//       path: '/collection-report',
//       builder: (BuildContext context, GoRouterState state) => const CollectionReportScreen(),
//     ),
//     GoRoute(
//       path: '/bcu-expenses',
//       builder: (BuildContext context, GoRouterState state) => const BCUExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/tabela-expenses',
//       builder: (BuildContext context, GoRouterState state) => const TabelaExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/home-expenses',
//       builder: (BuildContext context, GoRouterState state) => const HomeExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/employees',
//       builder: (BuildContext context, GoRouterState state) => const EmployeeListScreen(),
//     ),
//     GoRoute(
//       path: '/attendance',
//       builder: (BuildContext context, GoRouterState state) => const AttendanceScreen(),
//     ),
//     GoRoute(
//       path: '/payroll',
//       builder: (BuildContext context, GoRouterState state) => const PayrollScreen(),
//     ),
//     GoRoute(
//       path: '/loans',
//       builder: (BuildContext context, GoRouterState state) => const LoanListScreen(),
//     ),
//     GoRoute(
//       path: '/rates',
//       builder: (BuildContext context, GoRouterState state) => const RateConfigScreen(),
//     ),
//     GoRoute(
//       path: '/reports',
//       builder: (BuildContext context, GoRouterState state) => const ReportScreen(),
//     ),
//   ],
// );
