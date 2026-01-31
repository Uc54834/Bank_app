import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Lorem Ipsum Company',
      'subtitle': 'Received payment',
      'amount': '+\$2,030.80',
      'color': Colors.blue,
    },
    {
      'title': 'Auctor Elit Ltd.',
      'subtitle': 'Transfer money',
      'amount': '-\$450.00',
      'color': Colors.lightBlue,
    },
    {
      'title': 'Lectus Sit Amet est',
      'subtitle': 'Gas & electricity payment',
      'amount': '-\$239.50',
      'color': Colors.teal,
    },
    {
      'title': 'Congue Quisque',
      'subtitle': 'Withdraw money',
      'amount': '-\$1,500.00',
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TRANSACTION'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_tabButton('COMPLETE', 0), _tabButton('IN PROGRESS', 1)],
          ),

          const SizedBox(height: 15),

          // Transaction List
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: tx['color'],
                    radius: 10,
                  ),
                  title: Text(
                    tx['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tx['subtitle']),
                  trailing: Text(
                    tx['amount'],
                    style: TextStyle(
                      color: tx['amount'].startsWith('+')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // Pagination
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chevron_left),
                _pageCircle('1', false),
                _pageCircle('2', true),
                _pageCircle('3', false),
                _pageCircle('4', false),
                _pageCircle('5', false),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Widgets ----------

  Widget _tabButton(String text, int index) {
    final bool isActive = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.lightBlue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _pageCircle(String text, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.lightBlue : Colors.grey[300],
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? Colors.white : Colors.black),
      ),
    );
  }
}
