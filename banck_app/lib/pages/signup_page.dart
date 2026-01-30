import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0B4D78),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_balance, color: Colors.white, size: 80),
                  SizedBox(height: 10),
                  Text(
                    'Connect to your bank account',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildTextField('Your Name'),
            _buildTextField('Bank Account'),
            _buildTextField('Email'),
            _buildTextField('Password', isPassword: true),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Use 6 characters with a mix of letters, numbers & symbols.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            // Terms
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: const [
                  Checkbox(value: false, onChanged: null),
                  Expanded(
                    child: Text(
                      "By signing up, you agree to Bank's Term of Use & Privacy Policy.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B4D78),
                    minimumSize: const Size(120, 45),
                  ),
                  onPressed: () {
                    // TODO: Signup logic
                  },
                  child: const Text('SIGN UP',
                    style: TextStyle(
                    color: Colors.white,
                  ),
                 ),
                ),
                const SizedBox(width: 15),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Back to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already signed up? '),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text('Log in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTextField(String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
