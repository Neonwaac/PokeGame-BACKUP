// lib/models/pokemon.dart
class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final String type1;
  final String? type2;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type1,
    this.type2,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      type1: json['type1'] as String,
      type2: json['type2'], // puede ser null
    );
  }
}


