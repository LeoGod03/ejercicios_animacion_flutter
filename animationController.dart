import 'package:flutter/material.dart';
import 'dart:math'; // Para usar 'pi' (3.14159...)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ejemplo de AnimationController'),
        ),
        body: const Center(
          child: SpinningLogo(),
        ),
      ),
    );
  }
}

// 1. Usamos un StatefulWidget
class SpinningLogo extends StatefulWidget {
  const SpinningLogo({super.key});

  @override
  State<SpinningLogo> createState() => _SpinningLogoState();
}

//  este es el tickert que sincroniza con el VSync.
class _SpinningLogoState extends State<SpinningLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // inicializar el controlador
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // duración de una vuelta completa
    );

    //  el tween traduce el valor 0.0-1.0 del controller a 0-360 grados (2*pi)
    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    // evitar fugas de memoria.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // usamos el AnimateBuilder.
    return AnimatedBuilder(
      animation: _controller, // a quien escucha
      builder: (context, child) {
        // rotación
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: child,
        );
      },
      // aqui se pasa wl widget a animar para que flutter no lo reconstruya en cada fotograma
      child: const FlutterLogo(size: 100),
    );
  }
}