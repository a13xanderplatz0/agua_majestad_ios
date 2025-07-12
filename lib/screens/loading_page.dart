import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:math' as math;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador de rotación para el logo
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Controlador de pulso para efectos de respiración
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Controlador de deslizamiento para la entrada
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Animaciones
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animaciones
    _slideController.forward();

    // Navegar automáticamente al home después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2196F3),
              Color(0xFF0066CC),
              Color(0xFF003D82),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Efectos de fondo con círculos flotantes
            _buildBackgroundEffects(),
            
            // Contenido principal
            Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo con efectos
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.35,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/logos/majestad.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.04),
                      
                      // Nombre de la empresa con efecto de aparición
                      Text(
                        'MAJESTAD',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.01),
                      
                      // Subtítulo
                      Text(
                        'Agua pura para tu familia',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1,
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.06),
                      
                      // Indicador de carga moderno
                      _buildModernLoadingIndicator(),
                      
                      SizedBox(height: screenHeight * 0.03),
                      
                      // Texto de carga con animación
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 0.5 + (_pulseAnimation.value * 0.5),
                            child: Text(
                              'Preparando tu experiencia...',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Versión en la parte inferior
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Versión 1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundEffects() {
    return Stack(
      children: [
        // Círculos flotantes animados
        Positioned(
          top: 100,
          left: 50,
          child: _buildFloatingCircle(60, Colors.white.withOpacity(0.1)),
        ),
        Positioned(
          top: 200,
          right: 80,
          child: _buildFloatingCircle(40, Colors.white.withOpacity(0.08)),
        ),
        Positioned(
          bottom: 150,
          left: 80,
          child: _buildFloatingCircle(50, Colors.white.withOpacity(0.06)),
        ),
        Positioned(
          bottom: 250,
          right: 60,
          child: _buildFloatingCircle(35, Colors.white.withOpacity(0.1)),
        ),
      ],
    );
  }

  Widget _buildFloatingCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            20 * math.sin(_rotationController.value * 2 * math.pi),
            10 * math.cos(_rotationController.value * 2 * math.pi),
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernLoadingIndicator() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          // Círculo de fondo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          
          // Indicador de progreso circular
          RotationTransition(
            turns: _rotationController,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.8),
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
          ),
          
          // Círculo interior
          Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.water_drop_rounded,
                color: Color(0xFF0066CC),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}