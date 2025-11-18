import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SourcePage(),
    );
  }
}

// pantalla de origen
class SourcePage extends StatelessWidget {
  const SourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página 1: Origen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Toca el logo para volar'),
            const SizedBox(height: 20),

            // se envolve el widget en un GestureDetector para detectar el toque
            GestureDetector(
              onTap: () {
                // Navegamos a la segunda pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DestinationPage()),
                );
              },
              // logo en un widget hero
              child: const Hero(
                tag: 'mi-logo-volador',
                child: FlutterLogo(size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA 2 (DESTINO) ---
class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página 2: Destino')),
      backgroundColor: Colors.blue[50], // color de fondo
      body: Center(
        child: GestureDetector(
          onTap: () {
            // al tocar se quita la página de encima
            Navigator.pop(context);
          },
          // el logo con el cambio envuelto en un widget hero con el mismo tag
          child: const Hero(
            tag: 'mi-logo-volador', // ¡Mismo tag que en la página 1!
            child: FlutterLogo(size: 200), // Tamaño grande
          ),
        ),
      ),
    );
  }
}