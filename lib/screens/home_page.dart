import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'orders_page.dart';
import 'promotions_page.dart';
import 'notifications_page.dart';

// Página principal de la app con barra inferior de navegación y productos destacados
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'orders_page.dart';
import 'promotions_page.dart';
import 'cart_page.dart';

// Widget principal del Home con navegación inferior
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Índice de la pestaña seleccionada en la barra inferior
  int _selectedIndex = 0;

  // Lista de páginas para cada pestaña
  final List<Widget> _pages = [
    HomeContent(),      // Pantalla de inicio con productos
    OrdersPage(),       // Pantalla de pedidos
    CartPage(),         // Pantalla del carrito
    PromotionsPage(),   // Pantalla de promociones
    ProfilePage(),      // Pantalla de perfil
  ];

  // Cambia la pestaña seleccionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0066CC),
      // Muestra la página correspondiente a la pestaña seleccionada
      body: _pages[_selectedIndex],
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF0066CC),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildProductCard(String name, String size, String price, IconData icon, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardSize = constraints.maxWidth * 0.4;
        return Container(
          padding: EdgeInsets.all(cardSize * 0.05),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(cardSize * 0.04),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.2),
                blurRadius: cardSize * 0.02,
                offset: Offset(0, cardSize * 0.005),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: cardSize * 0.12,
                color: color,
              ),
              SizedBox(height: cardSize * 0.02),
              Text(
                name,
                style: TextStyle(
                  fontSize: cardSize * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: cardSize * 0.01),
              Text(
                size,
                style: TextStyle(
                  fontSize: cardSize * 0.04,
                  color: Color(0xFF666666),
                ),
              ),
              SizedBox(height: cardSize * 0.02),
              Text(
                price,
                style: TextStyle(
                  fontSize: cardSize * 0.06,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: cardSize * 0.02),
              CupertinoButton(
                padding: EdgeInsets.symmetric(
                  horizontal: cardSize * 0.04,
                  vertical: cardSize * 0.02
                ),
                color: color,
                borderRadius: BorderRadius.circular(cardSize * 0.04),
                child: Text(
                  'Agregar',
                  style: TextStyle(
                    fontSize: cardSize * 0.04,
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
      },
    );
  }

  Widget _buildFeatureItem(String text) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight * 0.1;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: itemHeight * 0.1),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.checkmark_circle,
                size: itemHeight * 0.6,
                color: Color(0xFF4CAF50),
              ),
              SizedBox(width: itemHeight * 0.2),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: itemHeight * 0.5,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Pantalla de inicio con productos destacados
class HomeContent extends StatelessWidget {
  // Lista de productos de ejemplo
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Agua Natural',
      'desc': '1L',
      'price': 'S/ 2.50',
      'image': 'assets/images/logos/botella.png',
    },
    {
      'name': 'Agua con Gas',
      'desc': '2L',
      'price': 'S/ 3.00',
      'image': 'assets/images/logos/majestad.png',
    },
    {
      'name': 'Agua Premium',
      'desc': '10L',
      'price': 'S/ 4.50',
      'image': 'assets/images/logos/majestad.png',
    },
    {
      'name': 'Pack Familiar',
      'desc': '20L',
      'price': 'S/ 8.00',
      'image': 'assets/images/logos/majestad.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section responsiva
          Container(
            width: double.infinity,
            height: screenHeight * 0.29, // Aumenta un poco la altura
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2196F3), // Azul claro
                  Color(0xFF0066CC), // Azul oscuro
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.05), // 5% del ancho
                bottomRight: Radius.circular(screenWidth * 0.05), // 5% del ancho
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo en círculo responsivo
                Container(
                  width: screenWidth * 0.11, // Más pequeño
                  height: screenWidth * 0.11, // Más pequeño
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: screenWidth * 0.012, // Más pequeño
                        offset: Offset(0, screenWidth * 0.006), // Más pequeño
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.008), // Más pequeño
                    child: Image.asset(
                      'assets/images/logos/majestad.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.007), // Más pequeño
                Text(
                  'Agua Majestad',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.032, // Más pequeño
                    fontWeight: FontWeight.bold,
                    letterSpacing: screenWidth * 0.0007, // Más pequeño
                  ),
                ),
                SizedBox(height: screenHeight * 0.003), // Más pequeño
                Text(
                  'Pura y Natural para tu familia',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.017, // Más pequeño
                  ),
                ),
                SizedBox(height: screenHeight * 0.008), // Más pequeño
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF0066CC),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025), // Más pequeño
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02, // Más pequeño
                      vertical: screenHeight * 0.006, // Más pequeño
                    ),
                  ),
                  icon: Icon(Icons.shopping_cart_checkout, size: screenWidth * 0.022), // Más pequeño
                  label: Text(
                    'Ordenar Ahora',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.017, // Más pequeño
                    ),
                  ),
                  onPressed: () {
                    // Acción para ordenar
                  },
                ),
              ],
            ),
          ),
          // Grid de productos responsivo
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025), // 2.5% del ancho
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuestros Productos',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% del ancho
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // 1% de la altura
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: screenWidth * 0.008,
                        crossAxisSpacing: screenWidth * 0.008,
                        childAspectRatio: 1.6, // mucho más compacto y bajo
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTapDown: (_) {},
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.002, vertical: screenWidth * 0.002), // mínimo padding
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(screenWidth * 0.005), // más compacto
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: screenWidth * 0.0015,
                                  offset: Offset(0, screenWidth * 0.0007),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: screenHeight * 0.01),
                                SizedBox(
                                  width: screenWidth * 0.09,
                                  height: screenWidth * 0.09,
                                  child: Image.asset(
                                    product['image'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  product['name'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.011,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0066CC),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  product['desc'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.009,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  product['price'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.012,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.006),
                                Center(
                                  child: SizedBox(
                                    width: screenWidth * 0.16,
                                    height: screenHeight * 0.027,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF0066CC),
                                        foregroundColor: Colors.white,
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(screenWidth * 0.005),
                                        ),
                                        elevation: 1,
                                      ),
                                      icon: Icon(Icons.add_shopping_cart, size: screenWidth * 0.011),
                                      label: Text(
                                        'Agregar',
                                        style: TextStyle(fontSize: screenWidth * 0.009),
                                      ),
                                      onPressed: () {
                                        // Acción para agregar al carrito
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Agregar el widget CartPage al final del archivo
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Text(
        'Aquí verás tu carrito de compras',
        style: TextStyle(
          fontSize: screenWidth * 0.04, // 4% del ancho de pantalla
          color: Colors.black54
        ),
      ),
    );
  }
}