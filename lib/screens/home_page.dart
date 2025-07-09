import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Agua Majestad',
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF0066CC), // Azul agua
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF004499),
            width: 1.0,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.cart,
            color: CupertinoColors.white,
            size: 24,
          ),
          onPressed: () {
            // Acción del carrito
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0066CC),
                    Color(0xFF004499),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.drop_fill,
                    size: 60,
                    color: CupertinoColors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Agua Pura y Natural',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'La mejor calidad para tu familia',
                    style: TextStyle(
                      color: CupertinoColors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25),
                    child: Text(
                      'Ordenar Ahora',
                      style: TextStyle(
                        color: Color(0xFF0066CC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      // Acción para ordenar
                    },
                  ),
                ],
              ),
            ),

            // Productos Destacados
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nuestros Productos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProductCard(
                          'Agua Natural',
                          '5L',
                          '\$2.50',
                          CupertinoIcons.drop,
                          Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildProductCard(
                          'Agua con Gas',
                          '2L',
                          '\$3.00',
                          CupertinoIcons.bubble_left,
                          Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProductCard(
                          'Agua Premium',
                          '10L',
                          '\$4.50',
                          CupertinoIcons.star_fill,
                          Color(0xFFFF9800),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildProductCard(
                          'Pack Familiar',
                          '20L',
                          '\$8.00',
                          CupertinoIcons.person_3_fill,
                          Color(0xFF9C27B0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Información de la Empresa
            Container(
              width: double.infinity,
              color: Color(0xFFF5F5F5),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    size: 50,
                    color: Color(0xFF4CAF50),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '¿Por qué elegirnos?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildFeatureItem('Agua 100% natural y purificada'),
                  _buildFeatureItem('Entrega a domicilio en 24 horas'),
                  _buildFeatureItem('Garantía de calidad'),
                  _buildFeatureItem('Precios competitivos'),
                ],
              ),
            ),

            // Call to Action
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    '¡Haz tu pedido hoy!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0066CC),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Recibe agua fresca en tu puerta',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 20),
                  CupertinoButton(
                    color: Color(0xFF0066CC),
                    borderRadius: BorderRadius.circular(25),
                    child: Text(
                      'Contactar',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      // Acción para contactar
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String size, String price, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 4),
          Text(
            size,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: color,
            borderRadius: BorderRadius.circular(15),
            child: Text(
              'Agregar',
              style: TextStyle(
                fontSize: 12,
                color: CupertinoColors.white,
              ),
            ),
            onPressed: () {
              // Acción para agregar al carrito
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.checkmark_circle,
            size: 20,
            color: Color(0xFF4CAF50),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}