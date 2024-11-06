class Computadora {
  final int? id;
  final String procesador;
  final String discoDuro;
  final String ram;

  Computadora(
      {this.id,
      required this.procesador,
      required this.discoDuro,
      required this.ram});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'procesador': procesador,
      'discoDuro': discoDuro,
      'ram': ram,
    };
  }

  static Computadora fromMap(Map<String, dynamic> map) {
    return Computadora(
      id: map['id'],
      procesador: map['procesador'],
      discoDuro: map['discoDuro'],
      ram: map['ram'],
    );
  }
}
