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
      home: StaggeredDemo(),
    );
  }
}

class StaggeredDemo extends StatefulWidget {
  const StaggeredDemo({super.key});

  @override
  State<StaggeredDemo> createState() => _StaggeredDemoState();
}

class _StaggeredDemoState extends State<StaggeredDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // definición de las múltiples animaciones
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    // el controlador principal dura 3 segundos
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // cambio en el ancho
    _widthAnimation = Tween<double>(begin: 50.0, end: 300.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.30, curve: Curves.ease),
      ),
    );

    // cambio en el alto
    _heightAnimation = Tween<double>(begin: 50.0, end: 300.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.60, curve: Curves.ease),
      ),
    );

    // cambio de color
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.orange).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 1.0, curve: Curves.easeIn),
      ),
    );

    //redondeo de bordes
    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(0),
      end: BorderRadius.circular(150), // Se hace círculo
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      // primero ejecuta la animación de manera secuencial
      await _controller.forward().orCancel;
      // después se ejecuta en reversa
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // La animación fue cancelada, no hacemos nada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animación secuencial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usamos AnimatedBuilder para redibujar cuando el controller cambie
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  // Asignamos los valores de las animaciones individuales
                  width: _widthAnimation.value,
                  height: _heightAnimation.value,
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: _borderRadiusAnimation.value,
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                _playAnimation();
              },
              child: const Text('Iniciar Secuencia'),
            ),
          ],
        ),
      ),
    );
  }
}