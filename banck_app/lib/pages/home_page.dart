import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_colors.dart';
import '../components/app_cards.dart';
import '../services/profile_service.dart';
import '../services/account_service.dart';
import '../services/transaction_service.dart';
import '../utils/responsive.dart';
import 'login_page.dart';
import 'account_page.dart';
import 'transaction_page.dart';
import 'transaction_history_page.dart';
import 'payment.dart';
import 'exchange_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'User';
  String email = '';
  double balance = 0.0;
  bool isLoading = true;
  List<Transaction> recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      // Load profile
      final profile = await ProfileService.getProfile();

      // Load account balance
      final balance = await AccountService.getBalance();

      // Load recent transactions
      final transactions = await TransactionService.getTransactions(limit: 5);

      if (!mounted) return;

      setState(() {
        name = profile?['name'] ?? 'User';
        email = profile?['email'] ?? '';
        this.balance = balance;
        recentTransactions = transactions;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildAppDrawer(context),
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildDesktopLayout(),
        desktop: _buildDesktopLayout(),
        wide: _buildDesktopLayout(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Dashboard',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textSecondary,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.textSecondary),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(name: name, email: email),
            const SizedBox(height: 24),
            BalanceCard(
              label: 'TOTAL BALANCE',
              amount: AccountService.formatBalance(balance),
              gradientColors: AppColors.primaryGradient,
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Quick Actions', actionText: 'See All'),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  QuickActionItem(
                    label: 'Transfer',
                    icon: Icons.swap_horiz,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransactionPage(),
                      ),
                    ),
                    backgroundColor: AppColors.primaryContainer,
                    iconColor: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  QuickActionItem(
                    label: 'Pay Bills',
                    icon: Icons.payment,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PaymentPage()),
                    ),
                    backgroundColor: AppColors.secondaryContainer,
                    iconColor: AppColors.secondary,
                  ),
                  const SizedBox(width: 12),
                  QuickActionItem(
                    label: 'Exchange',
                    icon: Icons.currency_exchange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ExchangePage()),
                    ),
                    backgroundColor: AppColors.accentContainer,
                    iconColor: AppColors.accent,
                  ),
                  const SizedBox(width: 12),
                  QuickActionItem(
                    label: 'History',
                    icon: Icons.history,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransactionHistoryPage(),
                      ),
                    ),
                    backgroundColor: const Color(0xFFFFF3E0),
                    iconColor: const Color(0xFFFF9800),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Recent Transactions',
              actionText: 'View All',
              onActionTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionHistoryPage(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildTransactionList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BalanceCard(
                        label: 'TOTAL BALANCE',
                        amount: AccountService.formatBalance(balance),
                        gradientColors: AppColors.primaryGradient,
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Quick Actions',
                        actionText: 'See All',
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            QuickActionItem(
                              label: 'Transfer',
                              icon: Icons.swap_horiz,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const TransactionPage(),
                                ),
                              ),
                              backgroundColor: AppColors.primaryContainer,
                              iconColor: AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                            QuickActionItem(
                              label: 'Pay Bills',
                              icon: Icons.payment,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PaymentPage(),
                                ),
                              ),
                              backgroundColor: AppColors.secondaryContainer,
                              iconColor: AppColors.secondary,
                            ),
                            const SizedBox(width: 12),
                            QuickActionItem(
                              label: 'Exchange',
                              icon: Icons.currency_exchange,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ExchangePage(),
                                ),
                              ),
                              backgroundColor: AppColors.accentContainer,
                              iconColor: AppColors.accent,
                            ),
                            const SizedBox(width: 12),
                            QuickActionItem(
                              label: 'History',
                              icon: Icons.history,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const TransactionHistoryPage(),
                                ),
                              ),
                              backgroundColor: const Color(0xFFFFF3E0),
                              iconColor: const Color(0xFFFF9800),
                            ),
                            const SizedBox(width: 12),
                            QuickActionItem(
                              label: 'Statements',
                              icon: Icons.receipt_long,
                              onTap: () {},
                              backgroundColor: const Color(0xFFE3F2FD),
                              iconColor: const Color(0xFF2196F3),
                            ),
                            const SizedBox(width: 12),
                            QuickActionItem(
                              label: 'Support',
                              icon: Icons.support_agent,
                              onTap: () {},
                              backgroundColor: const Color(0xFFFCE4EC),
                              iconColor: const Color(0xFFE91E63),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Recent Transactions',
                        actionText: 'View All',
                        onActionTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TransactionHistoryPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTransactionList(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      ProfileHeader(
                        name: name,
                        email: email,
                        onEditTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AccountPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Account Summary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildAccountSummaryItem(
                              'Account Number',
                              '00 123 456',
                            ),
                            const SizedBox(height: 12),
                            _buildAccountSummaryItem('Account Type', 'Premium'),
                            const SizedBox(height: 12),
                            _buildAccountSummaryItem('Branch', 'Main Street'),
                            const SizedBox(height: 12),
                            _buildAccountSummaryItem(
                              'Status',
                              'Active',
                              valueColor: AppColors.success,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    if (recentTransactions.isEmpty) {
      return AppCard(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'No recent transactions',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    return AppCard(
      child: Column(
        children: recentTransactions.map((tx) {
          final isCredit = tx.type == 'credit';
          return Column(
            children: [
              TransactionTile(
                title: tx.description.isNotEmpty
                    ? tx.description
                    : (isCredit ? 'Received' : 'Payment'),
                subtitle: _formatDate(tx.createdAt),
                amount:
                    '${isCredit ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
                isPositive: isCredit,
              ),
              if (tx != recentTransactions.last) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildAccountSummaryItem(
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  AccountService.formatBalance(balance),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payments'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PaymentPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text('Transactions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionHistoryPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange),
            title: const Text('Exchange Money'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExchangePage()),
              );
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
