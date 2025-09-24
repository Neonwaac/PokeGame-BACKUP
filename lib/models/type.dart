class PokeType {
  final String name;
  final String imageUrl;

  PokeType({required this.name, required this.imageUrl});

  factory PokeType.fromJson(Map<String, dynamic> json) {
    return PokeType(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
