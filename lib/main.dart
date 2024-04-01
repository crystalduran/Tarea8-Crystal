import 'package:flutter/material.dart';
import 'package:elecciones_20220553/screens/eventos_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elecciones Seguras',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: EventosScreen(),
    );
  }
}
