import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://telpibbkfmaxvguomppx.supabase.co',
    anonKey: 'sb_publishable_EgmPOB49G8bljbw8am5I6Q_hj5_h-1v',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank App',
      home: const LoginPage(),
    );
  }
}
