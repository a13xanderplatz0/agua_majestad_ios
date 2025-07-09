import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar y información básica
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Usuario Ejemplo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'usuario@ejemplo.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Opciones del perfil
            _buildProfileOption(
              icon: Icons.edit,
              title: 'Editar Perfil',
              onTap: () {
                // Acción para editar perfil
              },
            ),
            _buildProfileOption(
              icon: Icons.notifications,
              title: 'Notificaciones',
              onTap: () {
                // Acción para notificaciones
              },
            ),
            _buildProfileOption(
              icon: Icons.security,
              title: 'Seguridad',
              onTap: () {
                // Acción para seguridad
              },
            ),
            _buildProfileOption(
              icon: Icons.help,
              title: 'Ayuda',
              onTap: () {
                // Acción para ayuda
              },
            ),
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              onTap: () {
                // Acción para cerrar sesión
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
} 