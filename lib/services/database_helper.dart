import 'package:elecciones_20220553/models/evento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const int _version = 1;
  static const String _dbname = "Elecciones.db";
  static DatabaseHelper? _instance;

  DatabaseHelper._(); //Constructor privado para evitar instanciacion directa de DatabaseHelper

  // Método estático para obtener la instancia única de DatabaseHelper utilizando inicialización perezosa
  static DatabaseHelper getInstance() {
    _instance ??= DatabaseHelper._(); //Esto es inicializacion perezosa de la instancia
    return _instance!;
  }

  //Metodo privado para obtener la base de datos
  Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbname), //// Abre la base de datos en la ruta especificada
        onCreate: (db, version) async => // Define la creación de la base de datos si no existe
        await db.execute(
            "CREATE TABLE Eventos(id INTEGER PRIMARY KEY AUTOINCREMENT, fecha INTEGER NOT NULL, titulo TEXT NOT NULL, descripcion TEXT NOT NULL, image64bit TEXT, rutaArchivoAudio TEXT);"),
        version: _version
    );
  }

  //Metodo estatico para agregar eventos
  static Future<int> insertEvento(Evento evento) async {
    final db = await getInstance()._getDB();
    return await db.insert("Eventos", evento.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Metodo estatico para eliminar todos los eventos de la base de datos
  static Future<int> deleteAllEventos() async {
       final db = await getInstance()._getDB();
       return await db.delete("Eventos");
  }

  // Método estático para obtener todos los eventos de la base de datos
  static Future<List<Evento>?> getAllEventos() async {
    final db = await getInstance()._getDB();
    final List<Map<String, dynamic>> maps = await db.query("Eventos");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => Evento.fromJson(maps[index]));
  }

}