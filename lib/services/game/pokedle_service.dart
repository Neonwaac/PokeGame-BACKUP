// lib/services/game/pokedle_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../../models/pokemon.dart';

class PokedleService {
  final String baseUrl = "https://pokeapi.co/api/v2";
  List<Pokemon> _firstGenPokemon = [];

  // Obtiene la lista básica (name + url) y luego pide detalles en batches
  Future<List<Pokemon>> fetchFirstGeneration() async {
    if (_firstGenPokemon.isNotEmpty) return _firstGenPokemon;

    final listRes = await http.get(Uri.parse('$baseUrl/pokemon?limit=151'));
    if (listRes.statusCode != 200) throw Exception('Error al obtener lista de la API');

    final jsonList = json.decode(listRes.body) as Map<String, dynamic>;
    final results = (jsonList['results'] as List).cast<Map<String, dynamic>>();

    List<Pokemon> pokes = [];
    const int chunkSize = 20;
    for (int i = 0; i < results.length; i += chunkSize) {
      final chunk = results.sublist(i, (i + chunkSize).clamp(0, results.length));
      final futures = chunk.map((r) => http.get(Uri.parse(r['url'] as String))).toList();
      final responses = await Future.wait(futures);

      for (final resp in responses) {
        if (resp.statusCode == 200) {
          final data = json.decode(resp.body);
          try {
            pokes.add(Pokemon.fromJson(data));
          } catch (_) {
            // ignora si algo raro
          }
        }
      }
    }

    _firstGenPokemon = pokes;
    return _firstGenPokemon;
  }

  Future<Pokemon> getRandomPokemon() async {
    if (_firstGenPokemon.isEmpty) await fetchFirstGeneration();
    final rnd = Random();
    return _firstGenPokemon[rnd.nextInt(_firstGenPokemon.length)];
  }

  // lista de nombres (en minúsculas)
  List<String> get allNames => _firstGenPokemon.map((p) => p.name.toLowerCase()).toList();

  bool isValidName(String name) {
    final n = name.trim().toLowerCase();
    return _firstGenPokemon.any((p) => p.name.toLowerCase() == n);
  }

  // forzar recarga (si quieres)
  void clearCache() => _firstGenPokemon = [];
}
