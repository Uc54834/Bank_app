import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255),),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TRANSFER MONEY', 
          style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color.fromARGB(255, 255, 255, 255),),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Money icon section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.attach_money, size: 60, color: Color(0xFF0B4D78)),
                SizedBox(width: 20),
                Icon(Icons.sync_alt, size: 40, color: Color(0xFF0B4D78)),
              ],
            ),

            const SizedBox(height: 30),

            _inputField(
              label: 'From Bank Account',
              hint: '00 123 456',
              enabled: false,
            ),

            _dropdownField(
              label: 'To Bank Account',
              hint: 'SELECT',
            ),

            const SizedBox(height: 15),

            // Amount row
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Amount',
                style: _labelStyle(),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(value: '\$', child: Text('\$')),
                      DropdownMenuItem(value: '€', child: Text('€')),
                      DropdownMenuItem(value: '₹', child: Text('₹')),
                    ],
                    onChanged: (value) {},
                    decoration: _inputDecoration(),
                    hint: const Text('\$'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                      hint: '2,195.00',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            _inputField(
              label: 'Messages',
              hint: '',
              maxLines: 3,
            ),

            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B4D78),
                    ),
                    onPressed: () {},
                    child: const Text('SEND', 
                        style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 120,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------- Helpers ----------

  static TextStyle _labelStyle() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );
  }

  static InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static Widget _inputField({
    required String label,
    required String hint,
    bool enabled = true,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _labelStyle()),
          const SizedBox(height: 5),
          TextField(
            enabled: enabled,
            maxLines: maxLines,
            decoration: _inputDecoration(hint: hint),
          ),
        ],
      ),
    );
  }

  static Widget _dropdownField({
    required String label,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _labelStyle()),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(value: 'acc1', child: Text('Account 1')),
              DropdownMenuItem(value: 'acc2', child: Text('Account 2')),
            ],
            onChanged: (value) {},
            decoration: _inputDecoration(hint: hint),
          ),
        ],
      ),
    );
  }
}
