import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blueAccent,
      child: Text('Este es un widget de ejemplo', style: TextStyle(color: Colors.white)),
    );
  }
} 