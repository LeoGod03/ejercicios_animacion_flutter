import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Implícito vs. Explícito'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ejemplo 1: Animación Implícita',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ImplicitExample(),
              SizedBox(height: 40),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ejemplo 2: Animación Explícita',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ExplicitExample(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}


class ImplicitExample extends StatefulWidget {
  @override
  _ImplicitExampleState createState() => _ImplicitExampleState();
}

class _ImplicitExampleState extends State<ImplicitExample> {
  // Definimos las propiedades que queremos animar
  double _width = 100.0;
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);

  void _animate() {
    // setState() para cambiar las propiedades
    setState(() {
      final random = Random();
      _width = random.nextDouble() * 200 + 50; // Ancho aleatorio
      _color = Color.fromRGBO( // Color aleatorio
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      _borderRadius =
          BorderRadius.circular(random.nextDouble() * 50); // Borde aleatorio
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Toca el cuadrado para animar'),
        SizedBox(height: 16),
        GestureDetector(
          onTap: _animate,
          child: AnimatedContainer(
            width: _width,
            height: 100,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            //Solo definimos cuánto debe durar
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          ),
        ),
      ],
    );
  }
}


class ExplicitExample extends StatefulWidget {
  @override
  _ExplicitExampleState createState() => _ExplicitExampleState();
}

//Necesitamos 'SingleTickerProviderStateMixin' para el controlador
class _ExplicitExampleState extends State<ExplicitExample>
    with SingleTickerProviderStateMixin {
  //Declaramos el "cerebro" de la animación
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    //Inicializamos el controlador
    _controller = AnimationController(
      vsync: this, //
      duration: Duration(seconds: 2), // Duración de una vuelta
    );

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(_controller);

    // Iniciamos la animación para que se repita
    _controller.repeat();
  }

  @override
  void dispose() {
    //Desechar el controlador
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('La animación se repite sola'),
        SizedBox(height: 16),
        // Usamos AnimatedBuilder para escuchar los cambios
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value, //
              child: child, // El widget que no cambia
            );
          },
          child: FlutterLogo(size: 100),
        ),
      ],
    );
  }
}