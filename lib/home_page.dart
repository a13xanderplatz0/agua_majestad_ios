import 'package:flutter/cupertino.dart';


//la clase HomePage es un widget sin estado que representa la pantalla principal de la aplicación
/*
Usa StatelessWidget si la pantalla no cambia.
Usa StatefulWidget si la pantalla debe actualizarse cuando cambian los datos. */

class HomePage extends StatefulWidget{
  //aqui defino como se vera la pantalla 
  const  HomePage ({super.key});
  
  //@override:Estoy reemplazando un método que ya existe en la clase base
  @override
  State<HomePage> createState() => _HomePageState();
}

// Esta es la clase de estado, aquí va el método build
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Inicio',
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color(0xFF2E7D32), // Verde más oscuro y prominente
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF1B5E20),
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Text(
          '¡Bienvenido a la Home Page!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}