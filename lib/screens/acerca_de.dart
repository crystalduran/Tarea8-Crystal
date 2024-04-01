import 'package:elecciones_20220553/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
            'Acerca del Delegado',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/crystal.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Nombre: Crystal',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                'Apellido: Durán',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                'Matrícula: 2022-0553',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                '«La democracia es el gobierno del pueblo, por el pueblo, para el pueblo».',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                ),
              ),
              Text(
                'Abraham Lincoln (1808-1865). Político estadounidense.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
