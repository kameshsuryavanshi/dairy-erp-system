import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/api_client.dart';
import 'core/theme/app_theme.dart';

// ─── Providers ───────────────────────────────────────────────────────────────
final apiProvider = Provider((_) => ApiClient());
final sessionProvider = StateProvider<Session?>((_) => null);

class Session {
  const Session(this.token, this.user);
  final String token;
  final Map<String, dynamic> user;
}

// ─── App ──────────────────────────────────────────────────────────────────────
void main() => runApp(const ProviderScope(child: DairyFlowApp()));

class DairyFlowApp extends StatelessWidget {
  const DairyFlowApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'DairyFlow ERP',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Gate(),
      );
}

class Gate extends ConsumerWidget {
  const Gate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    return session == null ? const LoginPage() : const ShellPage();
  }
}

// ─── Login Page ───────────────────────────────────────────────────────────────
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _idCtrl = TextEditingController(text: 'admin@dairyflow.com');
  final _pwCtrl = TextEditingController(text: 'password123');
  String _role = 'admin';
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      final x = await ref.read(apiProvider).login({
        'role': _role,
        'identifier': _idCtrl.text.trim(),
        'password': _pwCtrl.text,
      });
      ref.read(apiProvider).setToken(x['access_token']);
      ref.read(sessionProvider.notifier).state = Session(
        x['access_token'],
        Map<String, dynamic>.from(x['user']),
      );
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
              e.response?.data['detail']?.toString() ?? 'Unable to sign in'),
        ));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Logo Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryBlue, AppTheme.accentBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.primaryBlue.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.local_shipping,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 14),
                        const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DAIRYFLOW',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 26,
                                      letterSpacing: 2)),
                              Text('OPERATIONS ERP',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                      letterSpacing: 3)),
                            ]),
                      ]),
                      const SizedBox(height: 16),
                      const Text(
                          'Integrated dairy management for BCUs, Tabelas and Home finance.',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Sign-in card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Sign in',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue)),
                        const SizedBox(height: 6),
                        Text('Access your operations workspace',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppTheme.textMuted)),
                        const SizedBox(height: 24),
                        // Role selector
                        DropdownButtonFormField<String>(
                          initialValue: _role,
                          decoration: InputDecoration(
                            labelText: 'Role',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(Icons.badge_outlined),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'admin', child: Text('Administrator')),
                            DropdownMenuItem(
                                value: 'bcu_manager',
                                child: Text('BCU Manager')),
                            DropdownMenuItem(
                                value: 'tabela_operator',
                                child: Text('Tabela Operator')),
                          ],
                          onChanged: (v) => setState(() {
                            _role = v!;
                            _idCtrl.text = v == 'admin'
                                ? 'admin@dairyflow.com'
                                : v == 'bcu_manager'
                                    ? 'BCU-001'
                                    : 'TAB-001';
                          }),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _idCtrl,
                          decoration: InputDecoration(
                            labelText: _role == 'admin' ? 'Email' : 'User Code',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _pwCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                        ),
                        const SizedBox(height: 22),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _loading ? null : _submit,
                          child: _loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2))
                              : const Text('Sign in',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppTheme.lightBlue,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text('Default password: password123',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: AppTheme.accentBlue)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shell (Main Navigation) ──────────────────────────────────────────────────
class ShellPage extends ConsumerStatefulWidget {
  const ShellPage({super.key});

  @override
  ConsumerState<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends ConsumerState<ShellPage> {
  int _tab = 0;

  static const _pages = [
    DashboardPage(),
    CollectionsPage(),
    ExpensesPage(),
    BcuPage(),
    EmployeesPage(),
    HomePage(),
    LoansPage(),
    RatesPage(),
    ReportsPage(),
  ];

  static const _titles = [
    'Dashboard',
    'Milk Collections',
    'Expenses',
    'BCU Operations',
    'Employees',
    'Home Expenses',
    'Loans',
    'Milk Rates',
    'Reports',
  ];

  static const _icons = [
    Icons.dashboard,
    Icons.water_drop,
    Icons.receipt_long,
    Icons.business,
    Icons.people,
    Icons.home,
    Icons.account_balance,
    Icons.currency_rupee,
    Icons.file_download,
  ];

  List<int> _getAllowedTabs(String role) {
    if (role == 'admin') return [0, 1, 2, 3, 4, 5, 6, 7, 8];
    if (role == 'bcu_manager') return [0, 1, 2, 3, 4, 8];
    return [0, 1, 2, 8];
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionProvider)!.user;
    final role = user['role'] as String;
    final allowed = _getAllowedTabs(role);
    final name = user['full_name'] ?? user['name'] ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tab],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
                child: Text(name,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 13))),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                color: AppTheme.primaryBlue,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.local_shipping,
                          color: Colors.white, size: 36),
                      const SizedBox(height: 10),
                      const Text('DAIRYFLOW',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 1.5)),
                      const Text('Operations ERP',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 12)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(role.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: allowed
                      .map((i) => ListTile(
                            selected: _tab == i,
                            selectedTileColor: AppTheme.lightBlue,
                            leading: Icon(_icons[i],
                                color: _tab == i
                                    ? AppTheme.primaryBlue
                                    : AppTheme.textMuted),
                            title: Text(_titles[i],
                                style: TextStyle(
                                  color: _tab == i
                                      ? AppTheme.primaryBlue
                                      : AppTheme.textDark,
                                  fontWeight: _tab == i
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                )),
                            onTap: () {
                              setState(() => _tab = i);
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sign out',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500)),
                onTap: () {
                  ref.read(sessionProvider.notifier).state = null;
                  ref.read(apiProvider).setToken(null);
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_tab],
    );
  }
}

// ─── Dashboard Page ───────────────────────────────────────────────────────────
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(apiProvider).dashboard(),
      builder: (context, s) {
        if (s.connectionState != ConnectionState.done) {
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        }
        if (s.hasError) {
          return _ErrorCard(message: 'Could not load dashboard: ${s.error}');
        }
        final d = Map<String, dynamic>.from(s.data as Map);
        final alerts = d['alerts'] as List? ?? [];
        final entries = d.entries
            .where((e) => e.key != 'alerts' && e.key != 'month')
            .toList();

        return RefreshIndicator(
          onRefresh: () => ref.read(apiProvider).dashboard(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(
                title: 'Operations Overview',
                subtitle: d['month']?.toString() ?? '',
                icon: Icons.dashboard,
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 640 ? 3 : 2,
                childAspectRatio: 1.45,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: entries
                    .map((e) => _MetricCard(
                          label: e.key.replaceAll('_', ' '),
                          value: _formatMetric(e.key, e.value),
                          icon: _metricIcon(e.key),
                          color: _metricColor(e.key),
                        ))
                    .toList(),
              ),
              if (alerts.isNotEmpty) ...[
                const SizedBox(height: 20),
                const _SectionHeader(
                    title: 'Overdue EMIs',
                    subtitle: 'Requires attention',
                    icon: Icons.warning_amber),
                const SizedBox(height: 10),
                ...alerts.map((a) {
                  final alert = Map<String, dynamic>.from(a as Map);
                  return Card(
                    color: Colors.red.shade50,
                    child: ListTile(
                      leading:
                          const Icon(Icons.warning_amber, color: Colors.red),
                      title: Text(alert['name']?.toString() ?? '—'),
                      subtitle: Text('Due: ${alert['due_date'] ?? ''}'),
                      trailing: Text('₹${alert['total_due'] ?? 0}',
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  );
                }),
              ],
            ],
          ),
        );
      },
    );
  }

  String _formatMetric(String key, dynamic value) {
    if (key.contains('expense') ||
        key.contains('revenue') ||
        key.contains('balance') ||
        key.contains('income')) {
      return '₹${value?.toString() ?? '0'}';
    }
    if (key.contains('liter')) return '${value?.toString() ?? '0'} L';
    return value?.toString() ?? '0';
  }

  IconData _metricIcon(String key) {
    if (key.contains('expense')) return Icons.receipt_long;
    if (key.contains('revenue') || key.contains('income'))
      return Icons.trending_up;
    if (key.contains('loan') || key.contains('balance'))
      return Icons.account_balance;
    if (key.contains('employee') || key.contains('count')) return Icons.people;
    if (key.contains('liter')) return Icons.water_drop;
    if (key.contains('attendance')) return Icons.check_circle;
    return Icons.analytics;
  }

  Color _metricColor(String key) {
    if (key.contains('expense')) return Colors.orange;
    if (key.contains('revenue') || key.contains('income'))
      return AppTheme.successGreen;
    if (key.contains('loan') || key.contains('balance')) return Colors.red;
    if (key.contains('employee') || key.contains('count'))
      return AppTheme.accentBlue;
    return AppTheme.primaryBlue;
  }
}

// ─── Collections Page ─────────────────────────────────────────────────────────
class CollectionsPage extends ConsumerStatefulWidget {
  const CollectionsPage({super.key});

  @override
  ConsumerState<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends ConsumerState<CollectionsPage> {
  bool _showForm = false;
  final _litersCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();
  final _snfCtrl = TextEditingController();
  String _shift = 'morning';
  String _milkType = 'buffalo';
  bool _submitting = false;

  Future<void> _addCollection() async {
    final session = ref.read(sessionProvider)!;
    final tabelaId = session.user['tabela_id'];
    if (tabelaId == null) return;
    setState(() => _submitting = true);
    try {
      await ref.read(apiProvider).post('/collection', {
        'tabela_id': tabelaId,
        'date': DateTime.now().toIso8601String().substring(0, 10),
        'shift': _shift,
        'milk_type': _milkType,
        'liters': double.tryParse(_litersCtrl.text) ?? 0,
        'fat_percent': double.tryParse(_fatCtrl.text) ?? 0,
        'snf_percent': double.tryParse(_snfCtrl.text) ?? 0,
      });
      setState(() {
        _showForm = false;
        _litersCtrl.clear();
        _fatCtrl.clear();
        _snfCtrl.clear();
      });
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Collection recorded!')));
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider)!;
    final tabelaId = session.user['tabela_id'];

    if (tabelaId == null &&
        session.user['role'] != 'admin' &&
        session.user['role'] != 'bcu_manager') {
      return const _AccessNotice(
          message: 'No tabela assigned. Contact your administrator.');
    }

    final path = tabelaId != null
        ? '/collection/$tabelaId'
        : '/collection/daily/${DateTime.now().toIso8601String().substring(0, 10)}';

    return FutureBuilder(
      future: ref.read(apiProvider).getList(path),
      builder: (context, s) {
        final canAdd = tabelaId != null;
        return Scaffold(
          backgroundColor: AppTheme.backgroundGrey,
          floatingActionButton: canAdd
              ? FloatingActionButton.extended(
                  backgroundColor: AppTheme.primaryBlue,
                  onPressed: () => setState(() => _showForm = !_showForm),
                  icon: Icon(_showForm ? Icons.close : Icons.add),
                  label: Text(_showForm ? 'Cancel' : 'Add Collection'),
                )
              : null,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_showForm) ...[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Add Milk Collection',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.primaryBlue)),
                        const SizedBox(height: 14),
                        Row(children: [
                          Expanded(
                              child: DropdownButtonFormField<String>(
                            initialValue: _shift,
                            decoration: const InputDecoration(
                                labelText: 'Shift',
                                border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(
                                  value: 'morning', child: Text('Morning')),
                              DropdownMenuItem(
                                  value: 'evening', child: Text('Evening')),
                            ],
                            onChanged: (v) => setState(() => _shift = v!),
                          )),
                          const SizedBox(width: 12),
                          Expanded(
                              child: DropdownButtonFormField<String>(
                            initialValue: _milkType,
                            decoration: const InputDecoration(
                                labelText: 'Milk Type',
                                border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(
                                  value: 'buffalo', child: Text('Buffalo')),
                              DropdownMenuItem(
                                  value: 'cow', child: Text('Cow')),
                            ],
                            onChanged: (v) => setState(() => _milkType = v!),
                          )),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Expanded(
                              child: TextFormField(
                                  controller: _litersCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Liters',
                                      border: OutlineInputBorder()))),
                          const SizedBox(width: 12),
                          Expanded(
                              child: TextFormField(
                                  controller: _fatCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Fat %',
                                      border: OutlineInputBorder()))),
                          const SizedBox(width: 12),
                          Expanded(
                              child: TextFormField(
                                  controller: _snfCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'SNF %',
                                      border: OutlineInputBorder()))),
                        ]),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue),
                            onPressed: _submitting ? null : _addCollection,
                            child: _submitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : const Text('Submit Collection'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (!s.hasData && s.connectionState != ConnectionState.done)
                const _LoadingCard()
              else if (s.hasError)
                _ErrorCard(message: 'Failed to load collections: ${s.error}')
              else ...[
                _SectionHeader(
                    title: 'Milk Collections',
                    subtitle: '${(s.data ?? []).length} records',
                    icon: Icons.water_drop),
                const SizedBox(height: 12),
                if ((s.data ?? []).isEmpty)
                  const _EmptyCard(message: 'No collections recorded yet.')
                else
                  ...(s.data as List).map((x) {
                    final item = Map<String, dynamic>.from(x as Map);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item['milk_type'] == 'buffalo'
                              ? Colors.blue.shade100
                              : Colors.amber.shade100,
                          child: Icon(Icons.water_drop,
                              color: item['milk_type'] == 'buffalo'
                                  ? AppTheme.accentBlue
                                  : Colors.amber.shade700),
                        ),
                        title: Text(
                            '${item['liters']} L · ${(item['milk_type'] as String).toUpperCase()}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            '${item['date']} · ${item['shift']} · Fat: ${item['fat_percent']}% · SNF: ${item['snf_percent']}%'),
                        trailing: Text('₹${item['total_amount']}',
                            style: const TextStyle(
                                color: AppTheme.successGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                    );
                  }),
              ],
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}

// ─── Expenses Page ─────────────────────────────────────────────────────────────
class ExpensesPage extends ConsumerStatefulWidget {
  const ExpensesPage({super.key});

  @override
  ConsumerState<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends ConsumerState<ExpensesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider)!;
    final role = session.user['role'] as String;

    return Column(
      children: [
        Container(
          color: AppTheme.primaryBlue,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: const [
              Tab(text: 'Tabela', icon: Icon(Icons.agriculture, size: 18)),
              Tab(text: 'BCU', icon: Icon(Icons.business, size: 18)),
              Tab(text: 'Home', icon: Icon(Icons.home, size: 18)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _TabelaExpenseView(session: session),
              role == 'tabela_operator'
                  ? const _AccessNotice(
                      message: 'BCU expenses are managed by the BCU manager.')
                  : _BcuExpenseView(session: session),
              role != 'admin'
                  ? const _AccessNotice(
                      message:
                          'Home expenses are available to administrators only.')
                  : const _HomeExpenseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabelaExpenseView extends ConsumerWidget {
  const _TabelaExpenseView({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabelaId = session.user['tabela_id'];
    if (tabelaId == null)
      return const _AccessNotice(
          message: 'No tabela assigned for this account.');
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/tabela/expenses/$tabelaId'),
      builder: (context, s) =>
          _ExpenseList(snapshot: s, title: 'Tabela Expenses'),
    );
  }
}

class _BcuExpenseView extends ConsumerWidget {
  const _BcuExpenseView({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bcuId = session.user['bcu_id'];
    if (bcuId == null)
      return const _AccessNotice(message: 'No BCU assigned for this account.');
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/bcu/expenses/$bcuId'),
      builder: (context, s) => _ExpenseList(snapshot: s, title: 'BCU Expenses'),
    );
  }
}

class _HomeExpenseView extends ConsumerWidget {
  const _HomeExpenseView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/home/expenses'),
      builder: (context, s) =>
          _ExpenseList(snapshot: s, title: 'Home Expenses'),
    );
  }
}

class _ExpenseList extends StatelessWidget {
  const _ExpenseList({required this.snapshot, required this.title});
  final AsyncSnapshot snapshot;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (!snapshot.hasData)
      return const Center(
          child: CircularProgressIndicator(color: AppTheme.primaryBlue));
    if (snapshot.hasError)
      return _ErrorCard(message: 'Error: ${snapshot.error}');
    final list = snapshot.data as List;
    if (list.isEmpty) return _EmptyCard(message: 'No $title recorded yet.');
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final x = Map<String, dynamic>.from(list[i] as Map);
        return Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: Icon(Icons.receipt_long, color: Colors.orange.shade700)),
            title: Text(x['category']?.toString() ?? 'Expense',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(x['date']?.toString() ?? ''),
            trailing: Text('₹${x['amount']}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15)),
          ),
        );
      },
    );
  }
}

// ─── BCU Page ─────────────────────────────────────────────────────────────────
class BcuPage extends ConsumerWidget {
  const BcuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider)!.user;
    if (user['role'] == 'tabela_operator')
      return const _AccessNotice(
          message:
              'BCU operations are available to BCU managers and administrators.');

    return FutureBuilder(
      future: ref.read(apiProvider).getList('/bcus'),
      builder: (context, s) {
        if (!s.hasData)
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        if (s.hasError) return _ErrorCard(message: 'Error: ${s.error}');
        final bcus = s.data as List;
        if (bcus.isEmpty)
          return const _EmptyCard(message: 'No BCUs configured.');
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: bcus.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final bcu = Map<String, dynamic>.from(bcus[i] as Map);
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppTheme.lightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.business,
                              color: AppTheme.primaryBlue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(bcu['name']?.toString() ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text(bcu['code']?.toString() ?? '',
                                  style: const TextStyle(
                                      color: AppTheme.textMuted, fontSize: 12)),
                            ])),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color:
                                  AppTheme.successGreen.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text('ACTIVE',
                              style: TextStyle(
                                  color: AppTheme.successGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      const Divider(height: 24),
                      Row(children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: AppTheme.textMuted),
                        const SizedBox(width: 4),
                        Text(bcu['location']?.toString() ?? 'N/A',
                            style: const TextStyle(
                                color: AppTheme.textMuted, fontSize: 13)),
                      ]),
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}

// ─── Employees Page ───────────────────────────────────────────────────────────
class EmployeesPage extends ConsumerWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider)!.user;
    if (user['role'] == 'tabela_operator')
      return const _AccessNotice(
          message:
              'Employee management is available to BCU managers and administrators.');
    final bcuId = user['bcu_id'];
    if (bcuId == null) {
      return FutureBuilder(
        future: ref.read(apiProvider).getList('/bcus'),
        builder: (ctx, s) {
          if (!s.hasData)
            return const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryBlue));
          final bcus = s.data as List;
          if (bcus.isEmpty) return const _EmptyCard(message: 'No BCUs found.');
          final firstBcu = Map<String, dynamic>.from(bcus.first as Map);
          return _EmployeeListForBcu(bcuId: firstBcu['id']);
        },
      );
    }
    return _EmployeeListForBcu(bcuId: bcuId);
  }
}

class _EmployeeListForBcu extends ConsumerWidget {
  const _EmployeeListForBcu({required this.bcuId});
  final dynamic bcuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/bcu/employees/$bcuId'),
      builder: (context, s) {
        if (!s.hasData)
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        final emps = s.data as List;
        if (emps.isEmpty)
          return const _EmptyCard(message: 'No employees found for this BCU.');
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: emps.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final emp = Map<String, dynamic>.from(emps[i] as Map);
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.lightBlue,
                  child: Text(
                      emp['name']?.toString().substring(0, 1).toUpperCase() ??
                          'E',
                      style: const TextStyle(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.bold)),
                ),
                title: Text(emp['name']?.toString() ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle:
                    Text('${emp['role']} · Joined ${emp['joining_date']}'),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${emp['salary']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue)),
                      Text(emp['is_active'] == 1 ? 'Active' : 'Inactive',
                          style: TextStyle(
                              fontSize: 11,
                              color: emp['is_active'] == 1
                                  ? AppTheme.successGreen
                                  : Colors.red)),
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}

// ─── Home Page ────────────────────────────────────────────────────────────────
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(sessionProvider)!.user['role'];
    if (role != 'admin')
      return const _AccessNotice(
          message: 'Home expenses are available only to administrators.');
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/home/expenses'),
      builder: (context, s) {
        if (!s.hasData && s.connectionState != ConnectionState.done)
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        if (s.hasError) return _ErrorCard(message: 'Error: ${s.error}');
        final list = s.data as List;
        if (list.isEmpty)
          return const _EmptyCard(message: 'No home expenses recorded yet.');
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final x = Map<String, dynamic>.from(list[i] as Map);
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Icon(Icons.home, color: Colors.green.shade700)),
                title: Text(x['category']?.toString() ?? 'Home Expense',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${x['date']} · ${x['person_name'] ?? ''}'),
                trailing: Text('₹${x['amount']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15)),
              ),
            );
          },
        );
      },
    );
  }
}

// ─── Loans Page ───────────────────────────────────────────────────────────────
class LoansPage extends ConsumerWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(sessionProvider)!.user['role'];
    if (role != 'admin')
      return const _AccessNotice(
          message: 'Loan management is available only to administrators.');
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/loans'),
      builder: (context, s) {
        if (!s.hasData && s.connectionState != ConnectionState.done)
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        if (s.hasError) return _ErrorCard(message: 'Error: ${s.error}');
        final list = s.data as List;
        if (list.isEmpty)
          return const _EmptyCard(message: 'No loans recorded yet.');
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final loan = Map<String, dynamic>.from(list[i] as Map);
            final isActive = loan['status'] == 'active';
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(loan['name']?.toString() ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.orange.shade50
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isActive ? 'ACTIVE' : 'PAID',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isActive
                                        ? Colors.orange.shade800
                                        : Colors.green.shade700),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 8),
                      Text('${loan['lender']} → ${loan['borrower']}',
                          style: const TextStyle(
                              color: AppTheme.textMuted, fontSize: 13)),
                      const SizedBox(height: 10),
                      Row(children: [
                        _LoanStat(
                            label: 'Principal',
                            value: '₹${loan['base_amount']}'),
                        const SizedBox(width: 16),
                        _LoanStat(
                            label: 'Interest',
                            value: '${loan['monthly_interest']}%/mo'),
                        const SizedBox(width: 16),
                        _LoanStat(
                            label: 'Remaining',
                            value: '₹${loan['remaining_balance']}',
                            valueColor:
                                isActive ? Colors.red : AppTheme.successGreen),
                      ]),
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}

class _LoanStat extends StatelessWidget {
  const _LoanStat({required this.label, required this.value, this.valueColor});
  final String label, value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: valueColor ?? AppTheme.textDark)),
      ]);
}

// ─── Rates Page ───────────────────────────────────────────────────────────────
class RatesPage extends ConsumerWidget {
  const RatesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(apiProvider).getList('/rates'),
      builder: (context, s) {
        if (!s.hasData && s.connectionState != ConnectionState.done)
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue));
        if (s.hasError) return _ErrorCard(message: 'Error: ${s.error}');
        final list = s.data as List;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _SectionHeader(
                title: 'Milk Rate Configuration',
                subtitle: 'Current effective rates per litre',
                icon: Icons.currency_rupee),
            const SizedBox(height: 16),
            ...list.map((x) {
              final rate = Map<String, dynamic>.from(x as Map);
              final isBuffalo = rate['milk_type'] == 'buffalo';
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isBuffalo
                            ? Colors.blue.shade50
                            : Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.water_drop,
                          color: isBuffalo
                              ? AppTheme.accentBlue
                              : Colors.amber.shade700,
                          size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(rate['milk_type'].toString().toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('Effective from ${rate['effective_from']}',
                              style: const TextStyle(
                                  color: AppTheme.textMuted, fontSize: 12)),
                        ])),
                    Text('₹${rate['rate']}/L',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppTheme.primaryBlue)),
                  ]),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

// ─── Reports Page ─────────────────────────────────────────────────────────────
class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  static const _reports = [
    ('collections', 'Milk Collections', Icons.water_drop),
    ('bcu-expenses', 'BCU Expenses', Icons.business),
    ('tabela-expenses', 'Tabela Expenses', Icons.agriculture),
    ('home-expenses', 'Home Expenses', Icons.home),
    ('loans', 'Loan Tracker', Icons.account_balance),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader(
            title: 'Reports & Exports',
            subtitle: 'Download operational data',
            icon: Icons.file_download),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 640 ? 3 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: _reports
              .map((r) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Download: /api/v1/reports/${r.$1}.csv')),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(r.$3, size: 32, color: AppTheme.primaryBlue),
                              const SizedBox(height: 10),
                              Text(r.$2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              const SizedBox(height: 6),
                              const Text('CSV • XLSX • PDF',
                                  style: TextStyle(
                                      fontSize: 10, color: AppTheme.textMuted)),
                            ]),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────
class _MetricCard extends StatelessWidget {
  const _MetricCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});
  final String label, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: color, size: 22),
            const Spacer(),
            Text(label.replaceAll('_', ' ').toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.textMuted)),
            const SizedBox(height: 4),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: color)),
          ]),
        ),
      );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(
      {required this.title, required this.subtitle, required this.icon});
  final String title, subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.textDark)),
          if (subtitle.isNotEmpty)
            Text(subtitle,
                style:
                    const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
        ]),
      ]);
}

class _AccessNotice extends StatelessWidget {
  const _AccessNotice({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: AppTheme.lightBlue, shape: BoxShape.circle),
              child: const Icon(Icons.lock_outline,
                  size: 48, color: AppTheme.primaryBlue),
            ),
            const SizedBox(height: 16),
            const Text('Access Restricted',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.textDark)),
            const SizedBox(height: 8),
            Text(message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: AppTheme.textMuted, fontSize: 14)),
          ]),
        ),
      );
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error_outline, size: 48, color: AppTheme.errorRed),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textMuted)),
          ]),
        ),
      );
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.inbox, size: 56, color: AppTheme.textMuted),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textMuted)),
          ]),
        ),
      );
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: CircularProgressIndicator(color: AppTheme.primaryBlue),
        ),
      );
}
