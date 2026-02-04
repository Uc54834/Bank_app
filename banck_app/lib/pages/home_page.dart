import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';
import 'account_page.dart';
import 'transaction_page.dart';
import 'transaction_history_page.dart';
import 'payment.dart';
import 'exchange_page.dart';
import '/services/profile_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'User';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await ProfileService.getProfile();
    final user = Supabase.instance.client.auth.currentUser;

    if (!mounted) return;

    setState(() {
      name = profile?['name'] ?? 'User';
      email = user?.email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildAppDrawer(context, name, email),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccountPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
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

      body: Column(
        children: [
          // 🔹 TOP PROFILE SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 25),
            decoration: const BoxDecoration(
              color: Color(0xFF0B4D78),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      size: 50, color: Color(0xFF0B4D78)),
                ),
                const SizedBox(height: 10),
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // BALANCE CARD
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ],
            ),
            child: Column(
              children: [
                const Text('BALANCE', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                const Text(
                  '\$4,180.20',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B4D78),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TransactionPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'TRANSFER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // LATEST TRANSACTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'LATEST TRANSACTIONS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransactionHistoryPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'more >>',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: _TransactionList(),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DRAWER ----------------

  Widget _buildAppDrawer(
      BuildContext context, String name, String email) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF0B4D78)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
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
        ],
      ),
    );
  }
}

// ---------------- TRANSACTION LIST ----------------

class _TransactionList extends StatelessWidget {
  const _TransactionList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TransactionTile(
          title: 'Lorem Ipsum Company',
          subtitle: 'Received payment',
          amount: '\$2,030.80',
        ),
        TransactionTile(
          title: 'Auctor Elit Ltd.',
          subtitle: 'Transfer money',
          amount: '-\$450.00',
        ),
        TransactionTile(
          title: 'Lectus Sit Amet est',
          subtitle: 'Gas & electricity payment',
          amount: '-\$239.50',
        ),
        TransactionTile(
          title: 'Congue Quisque',
          subtitle: 'Withdraw money',
          amount: '-\$1,500.00',
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFF0B4D78),
        radius: 6,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
