import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:elecciones_20220553/models/evento.dart';
import 'package:elecciones_20220553/services/database_helper.dart';
import 'package:elecciones_20220553/widgets/nav_bar.dart';
import 'package:path_provider/path_provider.dart';

import 'eventos_screen.dart';

class RegistroEventoScreen extends StatefulWidget {
  final Evento? evento;

  RegistroEventoScreen({Key? key, this.evento}) : super(key: key);

  @override
  _RegistroEventoScreenState createState() => _RegistroEventoScreenState();
}

class _RegistroEventoScreenState extends State<RegistroEventoScreen> {
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  String? byte64String;
  File? _audioFile;

  // Metodo para elegir la imagen y convertirla a base64
  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
    );
    if (image != null) {
      var imageBytes = await image.readAsBytes();
      setState(() {
        byte64String = base64Encode(imageBytes);
      });
    }
  }

  // Para elegir el audio y guardar el path
  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      setState(() {
        _audioFile = File(filePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          'Agregar Situación o Vivencia',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Titulo',
                  labelText: 'Titulo del evento',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(
                hintText: 'Descripcion',
                labelText: 'Descripcion del evento',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: pickImage,
              style: ElevatedButton.styleFrom(
                primary: byte64String != null ? Colors.green : Colors.red,
                onPrimary: Colors.white,
              ),
              child: Text(byte64String != null ? 'Imagen seleccionada' : 'Elegir Imagen'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickAudioFile,
              style: ElevatedButton.styleFrom(
                primary: _audioFile != null ? Colors.green : Colors.black,
                onPrimary: Colors.white,
              ),
              child: Text(_audioFile != null ? 'Audio seleccionado' : 'Elegir Audio'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final titulo = tituloController.text;
                    final descripcion = descripcionController.text;

                    if (titulo.isEmpty || descripcion.isEmpty || _audioFile == null) {
                      return;
                    }

                    final createdAt = widget.evento?.fecha ?? DateTime.now();
                    final model = Evento(
                      id: widget.evento?.id,
                      fecha: createdAt,
                      titulo: titulo,
                      descripcion: descripcion,
                      image64bit: byte64String,
                      rutaArchivoAudio: _audioFile!.path,
                    );

                    await DatabaseHelper.insertEvento(model);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EventosScreen()), // Reemplaza ListaEventosScreen con el nombre de tu pantalla de lista de eventos
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 0.75),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Agregar',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
