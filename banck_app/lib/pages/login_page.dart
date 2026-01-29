import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 300,
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
                  Text(
                    'WELCOME!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 100,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Username
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Username or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Login Button
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4D78),
                ),
                onPressed: () {
                  // TODO: Implement login logic
                },
                child: const Text('LOG IN'),
              ),
            ),

            const SizedBox(height: 15),

            // Forgot Password (optional placeholder)
            TextButton(
              onPressed: () {
                // TODO: Navigate to forgot password page
              },
              child: const Text('Forgot Password?'),
            ),

            // Sign Up link (NO direct import)
            TextButton(
              onPressed: () {
                // Navigation will be added after 
              },
              child: const Text('New to Bank Apps? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
