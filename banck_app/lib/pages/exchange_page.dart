import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String fromCurrency = '\$';
  String toCurrency = '£';

  String inputAmount = '';

  // Simple demo exchange rates
  final Map<String, double> rates = {
    '\$': 1.0,
    '£': 0.78,
    '€': 0.92,
    '₨': 309.50,
  };

  double get convertedAmount {
    if (inputAmount.isEmpty) return 0.0;

    final value = double.tryParse(inputAmount) ?? 0.0;
    return value * (rates[toCurrency]! / rates[fromCurrency]!);
  }

  void onKeyPressed(String key) {
    setState(() {
      if (key == 'X') {
        if (inputAmount.isNotEmpty) {
          inputAmount = inputAmount.substring(0, inputAmount.length - 1);
        }
      } else {
        inputAmount += key;
      }
    });
  }

  void swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text('EXCHANGE', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: const [Icon(Icons.settings, color: Colors.white)],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),

          // Currency icons & swap
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _currencyCircle(fromCurrency, const Color(0xFF0B4D78)),
              IconButton(
                icon: const Icon(
                  Icons.sync_alt,
                  size: 35,
                  color: Color(0xFF0B4D78),
                ),
                onPressed: swapCurrencies,
              ),
              _currencyCircle(toCurrency, Colors.lightBlue),
            ],
          ),

          const SizedBox(height: 25),

          // From field
          _amountField(
            currency: fromCurrency,
            value: inputAmount.isEmpty ? '0.00' : inputAmount,
            onCurrencyChanged: (val) {
              setState(() => fromCurrency = val!);
            },
          ),

          const SizedBox(height: 10),
          const Text('CONVERT TO', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),

          // To field
          _amountField(
            currency: toCurrency,
            value: convertedAmount.toStringAsFixed(2),
            onCurrencyChanged: (val) {
              setState(() => toCurrency = val!);
            },
          ),

          const SizedBox(height: 15),

          // Keypad
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              childAspectRatio: 1.4,
              children: [
                ...List.generate(9, (i) => _keyButton('${i + 1}')),
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

  // ---------------- Widgets ----------------

  Widget _currencyCircle(String symbol, Color color) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: color,
      child: Text(
        symbol,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _amountField({
    required String currency,
    required String value,
    required ValueChanged<String?> onCurrencyChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          DropdownButton<String>(
            value: currency,
            items: const [
              DropdownMenuItem(value: '\$', child: Text('\$')),
              DropdownMenuItem(value: '£', child: Text('£')),
              DropdownMenuItem(value: '€', child: Text('€')),
              DropdownMenuItem(value: '₨', child: Text('₨')),
            ],
            onChanged: onCurrencyChanged,
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

  Widget _keyButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B4D78),
          foregroundColor: Colors.white,
        ),
        onPressed: () => onKeyPressed(text),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
