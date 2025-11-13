import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'dart:ui'; // Para usar 'Paint' y 'Color'
import 'dart:math'; // Para 'Random'

//El punto de entrada principal de la aplicación Flutter
void main() {
  // Inicializa y corre el juego usando el widget 'GameWidget'
  runApp(
    GameWidget(
      game: FlappyBirdGame(),
    ),
  );
}

// La clase principal del juego
class FlappyBirdGame extends FlameGame with TapCallbacks {
  late Bird bird;
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    // Posiciona al pájaro en la pantalla
    bird = Bird(position: Vector2(size.x / 4, size.y / 2));
    add(bird);

    // Añade un componente 'TimerComponent' que generará tuberías
    // cada 1.5 segundos
    add(TimerComponent(
      period: 1.5,
      repeat: true,
      onTick: addPipes,
    ));
  }

  // Método para añadir un par de tuberías
  void addPipes() {
    if (isGameOver) return;

    final random = Random();
    const gapSize = 150.0; // Espacio entre tuberías
    const pipeWidth = 60.0;

    // Calcula el centro del hueco aleatoriamente
    final gapCenter =
        random.nextDouble() * (size.y - gapSize) + (gapSize / 2);

    // Añade la tubería superior
    add(Pipe(
      position: Vector2(size.x + pipeWidth, 0),
      size: Vector2(pipeWidth, gapCenter - gapSize / 2),
    ));

    // Añade la tubería inferior
    add(Pipe(
      position: Vector2(size.x + pipeWidth, gapCenter + gapSize / 2),
      size: Vector2(pipeWidth, size.y - (gapCenter + gapSize / 2)),
    ));
  }

  // Se llama cuando el usuario toca la pantalla
  @override
  void onTapDown(TapDownEvent event) {
    if (isGameOver) {
      // Si el juego ha terminado, reinicia
      isGameOver = false;
      // Remueve todas las tuberías
      removeAll(children.whereType<Pipe>());
      // Resetea la posición del pájaro
      bird.reset(Vector2(size.x / 4, size.y / 2));
    } else {
      // Si está jugando, salta
      bird.jump();
    }
  }

  @override
  void update(double dt) {
    if (isGameOver) return; // Si el juego terminó, no actualiza nada

    super.update(dt); // Llama al 'update' de todos los componentes (pájaro, tuberías)

    // Revisa colisiones con las tuberías
    for (final pipe in children.whereType<Pipe>()) {
      if (bird.toRect().overlaps(pipe.toRect())) {
        gameOver();
        return;
      }
      // Si una tubería sale de la pantalla, la elimina
      if (pipe.position.x < -pipe.size.x) {
        remove(pipe);
      }
    }

    // Revisa si el pájaro se salió por arriba o abajo
    if (bird.position.y > size.y || bird.position.y < 0) {
      gameOver();
    }
  }

  void gameOver() {
    isGameOver = true;
    // Podrías añadir un texto de "Game Over" aquí
    // Por ahora, solo imprimimos en la consola
    print("Game Over! Toca para reiniciar.");
  }
}

// El componente del Pájaro
class Bird extends PositionComponent {
  static const double GRAVITY = 800.0;
  static const double JUMP_FORCE = 350.0;

  double velocity = 0.0;
  final Paint _paint = Paint()..color = Colors.orange; // Color del pájaro

  Bird({required Vector2 position})
      : super(
    position: position,
    size: Vector2.all(40.0), // Tamaño del pájaro (40x40)
    anchor: Anchor.center,
  );

  @override
  void render(Canvas canvas) {
    // Dibuja un rectángulo simple (nuestro "pájaro")
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Aplica la gravedad
    velocity += GRAVITY * dt;
    // Mueve el pájaro basado en la velocidad vertical
    position.y += velocity * dt;
  }

  // Método para saltar
  void jump() {
    velocity = -JUMP_FORCE; // Aplica una velocidad hacia arriba
  }

  // Método para resetear el pájaro
  void reset(Vector2 newPosition) {
    position = newPosition;
    velocity = 0.0;
  }
}

// El componente de Tubería
class Pipe extends PositionComponent {
  static const double PIPE_SPEED = 200.0;
  final Paint _paint = Paint()..color = Colors.green; // Color de la tubería

  Pipe({required Vector2 position, required Vector2 size})
      : super(
    position: position,
    size: size,
  );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Mueve la tubería hacia la izquierda
    position.x -= PIPE_SPEED * dt;
  }
}