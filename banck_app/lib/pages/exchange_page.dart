import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String fromCurrency = 'USD';
  String toCurrency = 'LKR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('EXCHANGE'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),

          // Currency icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF0B4D78),
                child: Text(
                  'USD',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              SizedBox(width: 15),
              Icon(Icons.sync_alt, size: 40, color: Color(0xFF0B4D78)),
              SizedBox(width: 15),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.lightBlue,
                child: Text(
                  'LKR',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          _amountField(fromCurrency, '1,000.00', true),

          const SizedBox(height: 15),
          const Text('CONVERT TO', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 15),

          _amountField(toCurrency, '780.00', false),

          const SizedBox(height: 20),

          // Number pad
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              childAspectRatio: 1.4,
              children: [
                ...List.generate(9, (index) => _keyButton('${index + 1}')),
                _keyButton('00'),
                _keyButton('0'),
                _keyButton('X'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Amount field widget
  Widget _amountField(String currency, String value, bool isFrom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          DropdownButton<String>(
            value: currency,
            items: const [
              DropdownMenuItem(value: 'USD', child: Text('USD')),
              DropdownMenuItem(value: 'LKR', child: Text('LKR')),
              DropdownMenuItem(value: 'EURO', child: Text('EURO')),
            ],
            onChanged: (val) {
              setState(() {
                if (isFrom) {
                  fromCurrency = val!;
                } else {
                  toCurrency = val!;
                }
              });
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Number pad button (WHITE text)
  Widget _keyButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B4D78),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white, // ✅ WHITE NUMBER
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
