import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());//muestra la primer pantalla, le estamos pasando el widget MyApp
}

class MyApp extends StatelessWidget {//inicio widget principal. El statelessWidget no cambia con el tiempo, una vez que se dibuja la pantalla se queda igual
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(//nos pone el stilo de Adroid tema, navegacion, etc)
      home: Animacion1(),//el home nos indicca cual pantalla mostrar
    );
  }
}//fin widget principal

class Animacion1 extends StatefulWidget {//esta es una patalla con animacion. StatefulWidget si cambia de estado, pero solo estamos describiendo que widget es
  @override//cuando flutter necesita contruir la mantalla llama a createState()
  State<Animacion1> createState() => _Animacion1State();//se crea el objeto de la clase _Animacion1State
}
//y el _Animacion1State es donde guardamos lo que cambia
//esta es la clase del estado
//aqui estan la variables que cambian
//el metodo build() que se re dibuja
//setState()
//logica de animacion/interaccion
class _Animacion1State extends State<Animacion1> {
  //este es el estado de Animacion1,
  bool expand = false; //esta variable cambia con el click del boton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 1500),
                width: expand ? 150 : 100,
                height: expand ? 300 : 100,
                color: expand ? Colors.blueGrey : Colors.orangeAccent,
              ),

              SizedBox(height: 20),

              AnimatedOpacity(
                opacity: expand ? 1.0 : 0.3,
                duration: Duration(milliseconds: 800),
                child: Text(
                  "Hola Animacion",
                  style: TextStyle(fontSize: 30),
                ),
              ),

              SizedBox(height: 20),

              AnimatedAlign(
                duration: Duration(milliseconds: 700),
                alignment: expand ? Alignment.topRight : Alignment.bottomLeft,
                heightFactor: 1.0,
                child: Icon(
                  Icons.gamepad,
                  size: 40,
                  color: Colors.purple,
                ),
              ),
            ]

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {//metodo que avisa que se debe reconstruir el wieget build con el nuevo estado de la variable
            expand = !expand;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}