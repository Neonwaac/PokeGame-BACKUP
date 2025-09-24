import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/pokemon.dart';
import '../../models/type.dart';

class GuessTypeService {
  final List<PokeType> allTypes = [];
  final List<Pokemon> allPokemons = [];

  Future<void> fetchTypes() async {
    if (allTypes.isNotEmpty) return;

    final String rawData = await rootBundle.loadString('assets/data/types.json');
    final List<dynamic> data = json.decode(rawData);

    allTypes.clear();
    allTypes.addAll(data.map((e) => PokeType.fromJson(e)).toList());
  }

  Future<void> fetchPokemons() async {
    if (allPokemons.isNotEmpty) return;

    final String rawData = await rootBundle.loadString('assets/data/pokemons.json');
    final List<dynamic> data = json.decode(rawData);

    allPokemons.clear();
    allPokemons.addAll(data.map((e) => Pokemon.fromJson(e)).toList());
  }

  Future<Pokemon> getRandomPokemon() async {
    if (allPokemons.isEmpty) {
      await fetchPokemons();
    }
    allPokemons.shuffle();
    return allPokemons.first;
  }
}
