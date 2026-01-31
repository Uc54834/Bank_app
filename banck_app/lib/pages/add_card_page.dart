import 'package:flutter/material.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 240, 236, 236),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ADD CARD',
          style: TextStyle(
            color: Color.fromARGB(255, 243, 239, 239),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Card preview
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'BANK NAME',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '•••• •••• •••• ••••',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _inputField(label: 'YOUR NAME', hint: 'NAME'),
            _inputField(
              label: 'CARD NUMBER',
              hint: 'INSERT YOUR CARD NUMBER',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            // Expiry Date
            Align(
              alignment: Alignment.centerLeft,
              child: Text('EXPIRED DATE', style: _labelStyle()),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _dropdown(['Day']),
                const SizedBox(width: 10),
                _dropdown(['Month']),
                const SizedBox(width: 10),
                _dropdown(['Year']),
              ],
            ),

            const SizedBox(height: 15),

            _inputField(label: 'PASSWORD', hint: '********', obscure: true),

            _inputField(
              label: 'PHONE NUMBER',
              hint: '+44',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 10),

            // Notes
            const Text(
              '* Nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non.\n'
              '* Nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Link Card Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4D78),
                ),
                onPressed: () {},
                child: const Text('LINK CARD'),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static TextStyle _labelStyle() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );
  }

  static Widget _inputField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _labelStyle()),
          const SizedBox(height: 5),
          TextField(
            keyboardType: keyboardType,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _dropdown(List<String> items) {
    return Expanded(
      child: DropdownButtonFormField(
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {},
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        hint: Text(items.first),
      ),
    );
  }
}
