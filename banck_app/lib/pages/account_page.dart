import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4D78),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('ACCOUNT', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.settings, color: Color.fromARGB(255, 255, 255, 255),), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile icon
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF0B4D78),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 30),

            _buildField(label: 'YOUR NAME', value: 'KARINA BUYS'),
            _buildField(label: 'BANK ACCOUNT', value: '00 123 456'),
            _buildField(label: 'EMAIL', value: 'karina_buys@email.com'),
            _buildField(label: 'PASSWORD', value: '********', isPassword: true),
            _buildField(label: 'PHONE NUMBER', value: '+44 558 257 68 005'),
            _buildAddressField(),

            const SizedBox(height: 10),

            // Note
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '* Nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 25),

            // Save button
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4D78),
                ),
                onPressed: () {},
                child: const Text('SAVE CHANGES', style: TextStyle(color: Colors.white,)),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Reusable input field
  static Widget _buildField({
    required String label,
    required String value,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: value,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildAddressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR ADDRESS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'Lorem ipsum 22nd street,\nTincidunt ut laoreet\n5N 27T - Lorem Ipsum',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
