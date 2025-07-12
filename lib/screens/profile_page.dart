import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Header con gradiente
          SliverAppBar(
            expandedHeight: screenHeight * 0.32, // Más alto para evitar overflow
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0066CC),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Avatar con efecto glassmorphism
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_rounded,
                              size: 45,
                              color: Color(0xFF0066CC),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Información del usuario
                        Text(
                          'Usuario Ejemplo',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08, // Más pequeño
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'usuario@ejemplo.com',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Badge de cliente
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Cliente Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Estadísticas del usuario
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard('Pedidos', '12', Icons.shopping_bag_rounded, const Color(0xFF4FC3F7)),
                        _buildDivider(),
                        _buildStatCard('Puntos', '850', Icons.stars_rounded, const Color(0xFFFFB74D)),
                        _buildDivider(),
                        _buildStatCard('Ahorros', 'S/ 45', Icons.savings_rounded, const Color(0xFF81C784)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sección de cuenta
                  Text(
                    'Mi Cuenta',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildModernProfileOption(
                    icon: Icons.edit_rounded,
                    title: 'Editar Perfil',
                    subtitle: 'Actualiza tu información personal',
                    color: const Color(0xFF2196F3),
                    onTap: () {
                      // Acción para editar perfil
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.location_on_rounded,
                    title: 'Direcciones',
                    subtitle: 'Gestiona tus direcciones de entrega',
                    color: const Color(0xFF4CAF50),
                    onTap: () {
                      // Acción para direcciones
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.credit_card_rounded,
                    title: 'Métodos de Pago',
                    subtitle: 'Administra tus tarjetas y métodos',
                    color: const Color(0xFF9C27B0),
                    onTap: () {
                      // Acción para métodos de pago
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sección de configuración
                  Text(
                    'Configuración',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildModernProfileOption(
                    icon: Icons.notifications_rounded,
                    title: 'Notificaciones',
                    subtitle: 'Configura alertas y avisos',
                    color: const Color(0xFFFF9800),
                    onTap: () {
                      // Acción para notificaciones
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.security_rounded,
                    title: 'Seguridad',
                    subtitle: 'Privacidad y seguridad de cuenta',
                    color: const Color(0xFFF44336),
                    onTap: () {
                      // Acción para seguridad
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.language_rounded,
                    title: 'Idioma',
                    subtitle: 'Español (Predeterminado)',
                    color: const Color(0xFF607D8B),
                    onTap: () {
                      // Acción para idioma
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sección de soporte
                  Text(
                    'Soporte',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildModernProfileOption(
                    icon: Icons.help_rounded,
                    title: 'Centro de Ayuda',
                    subtitle: 'Preguntas frecuentes y soporte',
                    color: const Color(0xFF00BCD4),
                    onTap: () {
                      // Acción para ayuda
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.feedback_rounded,
                    title: 'Enviar Comentarios',
                    subtitle: 'Comparte tu experiencia con nosotros',
                    color: const Color(0xFF795548),
                    onTap: () {
                      // Acción para comentarios
                    },
                  ),
                  
                  _buildModernProfileOption(
                    icon: Icons.info_rounded,
                    title: 'Acerca de',
                    subtitle: 'Información de la aplicación',
                    color: const Color(0xFF9E9E9E),
                    onTap: () {
                      // Acción para información
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Botón de cerrar sesión
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE57373)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFE57373),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            color: const Color(0xFFE57373),
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _buildModernProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.grey,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}