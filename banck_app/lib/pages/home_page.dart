import 'package:flutter/material.dart';
import 'account_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: Color.fromARGB(255, 255, 255, 255),), onPressed: () {}),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color.fromARGB(255, 255, 255, 255),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Profile Section
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
              children: const [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF0B4D78)),
                ),
                SizedBox(height: 10),
                Text(
                  'YOUR NAME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'your-email@email.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Balance Card
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
                const Text('BALANCE', style: TextStyle(color: Colors.grey),),
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
                    onPressed: () {},
                    child: const Text('TRANSFER', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Latest Transactions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'LATEST TRANSACTIONS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text('more >>', style: TextStyle(color: Color(0xFF0B4D78))),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
            ),
          ),
        ],
      ),
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
