import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // importación del paquete

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ejemplo Lottie'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'esta animación no es un video ni un GIF.\nes código JSON renderizado en tiempo real.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // se usa .network para cargarla desde internet para este ejemplo.
              // en un ejemplo más real se usaría Lottie.asset('assets/animacion.json')
              Lottie.network(
                // URL de una animación de prueba oficial
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/LottieLogo1.json',
                height: 250,
                width: 250,
                //controlar si se repite
                repeat: true,
                //controlar si se invierte
                reverse: false,
                // animar solo cuando carga
                animate: true,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(), // Solo para comparar estilos
            ],
          ),
        ),
      ),
    );
  }
}