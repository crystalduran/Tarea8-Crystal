import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:elecciones_20220553/models/evento.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class DetallesEventoScreen extends StatefulWidget {
  final Evento evento;

  const DetallesEventoScreen({Key? key, required this.evento}) : super(key: key);

  @override
  _DetallesEventoScreenState createState() => _DetallesEventoScreenState();
}

class _DetallesEventoScreenState extends State<DetallesEventoScreen> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.isPlaying.listen((event) {
      setState(() {
        isPlaying = event;
      });
    });
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio(String audioPath) async {
    if (await File(audioPath).exists()) {
      try {
        await _assetsAudioPlayer.open(
          Audio.file(audioPath),
          showNotification: true, // Mostrar notificación en la barra de notificaciones
          autoStart: true, // Comenzar la reproducción automáticamente
        );
      } catch (e) {
        print('Error al reproducir el audio: $e');
      }
    } else {
      print('Archivo de audio no encontrado en: $audioPath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del Evento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Título: ${widget.evento.titulo}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Descripción:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${widget.evento.descripcion}',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Fecha:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black87, size: 18),
                      SizedBox(width: 8),
                      Text(
                        '${widget.evento.fecha}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                if (widget.evento.image64bit != null)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: MemoryImage(Base64Decoder().convert(widget.evento.image64bit!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isPlaying) {
                          await _assetsAudioPlayer.pause();
                        } else {
                          await playAudio('${widget.evento.rutaArchivoAudio}');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: isPlaying ? Colors.red : Colors.green,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(isPlaying ? 'Pausar Audio' : 'Reproducir Audio', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
