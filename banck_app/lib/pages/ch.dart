import 'package:flutter/material.dart';

import 'account_page.dart';

class chamikara extends StatefulWidget {
  const chamikara({super.key});

  @override
  State<chamikara> createState() => _chamikaraState();
}

class _chamikaraState extends State<chamikara> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chamikara"),
        actions: [
          Icon(Icons.menu),
        ],

        leading:,

      ),
    )
  }
}