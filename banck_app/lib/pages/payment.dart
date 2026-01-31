import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final List<Map<String, dynamic>> items = [
    {"icon": Icons.water_drop, "label": "Water", "color": Colors.lightBlue},
    {"icon": Icons.lightbulb, "label": "Electricity", "color": Colors.amber},
    {"icon": Icons.local_fire_department, "label": "Gas", "color": Colors.red},
    {"icon": Icons.shopping_bag, "label": "Shopping", "color": Colors.pink},
    {"icon": Icons.phone_android, "label": "Phone", "color": Colors.blue},
    {"icon": Icons.credit_card, "label": "Credit Card", "color": Colors.green},
    {"icon": Icons.security, "label": "Insurance", "color": Colors.teal},
    {"icon": Icons.home, "label": "Mortgage", "color": Colors.deepPurple},
    {"icon": Icons.receipt_long, "label": "Other Bills", "color": Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: const Text("PAYMENT",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,     
            ),             
          ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255),),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.settings, color: Color.fromARGB(255, 255, 255, 255),),
          )
        ],
      ),
      body: Column(
        children: [
          // Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: const Color(0xFF0B4D78),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  "BALANCE",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 5),
                Text(
                  "\$4,180.20",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Grid Menu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: items[index]['color'],
                        child: Icon(
                          items[index]['icon'],
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        items[index]['label'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "more >>",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}