// Crystal Arianna Duran Nuñez 2022-0553

class Evento {
  final int? id;
  DateTime fecha;
  final String titulo;
  final String descripcion;
  final String? image64bit;
  final String? nombreAudio;
  final String? rutaArchivoAudio;

  Evento({
    this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    this.image64bit,
    this.nombreAudio,
    this.rutaArchivoAudio
  });

  // Este método se utiliza para construir un objeto Evento a partir de datos JSON.
  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
      id: json['id'],
      fecha: DateTime.fromMicrosecondsSinceEpoch(json['fecha']),
      titulo: json ['titulo'],
      descripcion: json ['descripcion'],
      image64bit: json['image64bit'],
      rutaArchivoAudio: json['rutaArchivoAudio']
  );

  //Este método se utiliza para serializar un objeto Evento en JSON.
  Map<String, dynamic> toJson() => {
    'id': id,
    'fecha': fecha.microsecondsSinceEpoch,
    'titulo': titulo,
    'descripcion': descripcion,
    'image64bit': image64bit,
    'rutaArchivoAudio': rutaArchivoAudio
  };

}