import 'package:flutter/material.dart';


class Extra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Extra",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,

      ),
      body: Center(
        child: Text(
          'Extra Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}