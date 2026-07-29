// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:../auth/presentation/login_screen.dart';
// import 'package:../auth/presentation/splash_screen.dart';
// import 'package:../dashboard/presentation/admin_dashboard.dart';
// import 'package:../dashboard/presentation/bcu_dashboard.dart';
// import 'package:../dashboard/presentation/tabela_dashboard.dart';
// import 'package:../collection/presentation/collection_screen.dart';
// import 'package:../collection/presentation/collection_history.dart';
// import 'package:../collection/presentation/collection_report.dart';
// import 'package:../expenses/presentation/bcu_expense_screen.dart';
// import 'package:../expenses/presentation/tabela_expense_screen.dart';
// import 'package:../expenses/presentation/home_expense_screen.dart';
// import 'package:../employees/presentation/employee_list_screen.dart';
// import 'package:../employees/presentation/attendance_screen.dart';
// import 'package:../employees/presentation/payroll_screen.dart';
// import 'package:../loans/presentation/loan_list_screen.dart';
// import 'package:../rates/presentation/rate_config_screen.dart';
// import 'package:../reports/presentation/report_screen.dart';

// final GoRouter appRouter = GoRouter(
//   initialLocation: '/',
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) =>
//           const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (BuildContext context, GoRouterState state) =>
//           const LoginScreen(),
//     ),
//     GoRoute(
//       path: '/admin-dashboard',
//       builder: (BuildContext context, GoRouterState state) =>
//           const AdminDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/bcu-dashboard',
//       builder: (BuildContext context, GoRouterState state) =>
//           const BCUDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/tabela-dashboard',
//       builder: (BuildContext context, GoRouterState state) =>
//           const TabelaDashboardScreen(),
//     ),
//     GoRoute(
//       path: '/collection',
//       builder: (BuildContext context, GoRouterState state) =>
//           const CollectionScreen(),
//     ),
//     GoRoute(
//       path: '/collection-history',
//       builder: (BuildContext context, GoRouterState state) =>
//           const CollectionHistoryScreen(),
//     )
//     GoRoute(
//       path: '/collection-report',
//       builder: (BuildContext context, GoRouterState state) =>
//           const CollectionReportScreen(),
//     ),
//     GoRoute(
//       path: '/bcu-expenses',
//       builder: (BuildContext context, GoRouterState state) =>
//           const BCUExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/tabela-expenses',
//       builder: (BuildContext context, GoRouterState state) =>
//           const TabelaExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/home-expenses',
//       builder: (BuildContext context, GoRouterState state) =>
//           const HomeExpenseScreen(),
//     ),
//     GoRoute(
//       path: '/employees',
//       builder: (BuildContext context, GoRouterState state) =>
//           const EmployeeListScreen(),
//     ),
//     GoRoute(
//       path: '/attendance',
//       builder: (BuildContext context, GoRouterState state) =>
//           const AttendanceScreen(),
//     ),
//     GoRoute(
//       path: '/payroll',
//       builder: (BuildContext context, GoRouterState state) =>
//           const PayrollScreen(),
//     ),
//     GoRoute(
//       path: '/loans',
//       builder: (BuildContext context, GoRouterState state) =>
//           const LoanListScreen(),
//     ),
//     GoRoute(
//       path: '/rates',
//       builder: (BuildContext context, GoRouterState state) =>
//           const RateConfigScreen(),
//     ),
//     GoRoute(
//       path: '/reports',
//       builder: (BuildContext context, GoRouterState state) =>
//           const ReportScreen(),
//     ),
//   ],
// );

// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// FIXED: Correct import paths (using relative imports)
import '../auth/presentation/login_screen.dart';
import '../auth/presentation/splash_screen.dart';
import '../dashboard/presentation/admin_dashboard.dart';
import '../dashboard/presentation/bcu_dashboard.dart';
import '../dashboard/presentation/tabela_dashboard.dart';
import '../collection/presentation/collection_screen.dart';
import '../collection/presentation/collection_history.dart';
import '../collection/presentation/collection_report.dart';
import '../expenses/presentation/bcu_expense_screen.dart';
import '../expenses/presentation/tabela_expense_screen.dart';
import '../expenses/presentation/home_expense_screen.dart';
import '../employees/presentation/employee_screen.dart';
import '../loans/presentation/loan_tracker_screen.dart';
import '../rates/presentation/rate_config_screen.dart';
import '../reports/presentation/report_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/bcu-dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const BCUDashboardScreen(),
    ),
    GoRoute(
      path: '/tabela-dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const TabelaDashboardScreen(),
    ),
    GoRoute(
      path: '/collection',
      builder: (BuildContext context, GoRouterState state) =>
          const CollectionScreen(),
    ),
    GoRoute(
      path: '/collection-history',
      builder: (BuildContext context, GoRouterState state) =>
          const CollectionHistoryScreen(),
    ), // ✅ Added missing comma
    GoRoute(
      path: '/collection-report',
      builder: (BuildContext context, GoRouterState state) =>
          const CollectionReportScreen(),
    ),
    GoRoute(
      path: '/bcu-expenses',
      builder: (BuildContext context, GoRouterState state) =>
          const BCUExpenseScreen(),
    ),
    GoRoute(
      path: '/tabela-expenses',
      builder: (BuildContext context, GoRouterState state) =>
          const TabelaExpenseScreen(),
    ),
    GoRoute(
      path: '/home-expenses',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeExpenseScreen(),
    ),
    GoRoute(
      path: '/employees',
      builder: (BuildContext context, GoRouterState state) =>
          const EmployeeScreen(),
    ),
    GoRoute(
      path: '/loans',
      builder: (BuildContext context, GoRouterState state) =>
          const LoanTrackerScreen(),
    ),
    GoRoute(
      path: '/rates',
      builder: (BuildContext context, GoRouterState state) =>
          const RateConfigScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (BuildContext context, GoRouterState state) =>
          const ReportScreen(),
    ),
    // ✅ FIXED: Added missing routes
    GoRoute(
      path: '/attendance',
      builder: (BuildContext context, GoRouterState state) =>
          const AttendanceScreen(),
    ),
    GoRoute(
      path: '/payroll',
      builder: (BuildContext context, GoRouterState state) =>
          const PayrollScreen(),
    ),
  ],
);
