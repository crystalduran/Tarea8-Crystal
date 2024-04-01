import 'package:flutter/material.dart';
import '../screens/eventos_screen.dart';
import '../screens/registro_evento_screen.dart';
import '../screens/acerca_de.dart';
import '../services/database_helper.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Future<void> _confirmarEliminacionRegistros(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Usuario debe hacer clic en el botón para cerrar la alerta
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Eliminar todos los registros?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro de que desea eliminar todos los registros almacenados?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la alerta sin eliminar los registros
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                DatabaseHelper.deleteAllEventos(); // Ejemplo de cómo eliminar todos los eventos usando un método estático
                Navigator.of(context).pop(); // Cierra la alerta después de eliminar los registros
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventosScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
                'Elecciones de Ciudad Paleta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text('Delegado'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/pokeball-6893.png')),
            ),
            decoration: BoxDecoration(
                color: Colors.red
            ),
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Lista de Eventos'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosScreen()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Registro de Eventos'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroEventoScreen())
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcercaDePage())
            ),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever), // Icono de eliminación
            title: Text('Eliminar Eventos'),
            onTap: () => _confirmarEliminacionRegistros(context), // Llama al método para mostrar la alerta de confirmación
          ),
        ],
      ),
    );
  }
}
