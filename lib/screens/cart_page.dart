import 'package:flutter/material.dart';

// Pantalla base para el carrito de compras
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Aquí verás tu carrito de compras',
        style: TextStyle(fontSize: 22, color: Colors.black54),
      ),
    );
  }
} 