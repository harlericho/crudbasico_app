import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'menu_screen.dart';

class BienvenidaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PcTOOLS')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto en la parte superior de la imagen
            Text(
              'Gestión de Computadoras',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'CRUD de registros de computadoras',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Imagen de computadora
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            // Texto animado
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Bienvenido a PcTOOLS',
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 20),
            // Botón con icono para navegar a MenuScreen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              icon: Icon(Icons.computer), // Icono de computadora
              label: Text('Ver Computadoras'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const Spacer(),
            // Animación de copyright en la parte inferior
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    '© 2024 PcTOOLS, Inc. Todos los derechos reservados.',
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    duration: const Duration(milliseconds: 3000),
                  ),
                ],
                repeatForever: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
