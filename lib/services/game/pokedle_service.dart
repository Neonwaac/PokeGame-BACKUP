import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../models/pokemon.dart';

class PokedleService {
  final List<Pokemon> allPokemons = [];

  Future<void> fetchFirstGeneration() async {
    if (allPokemons.isNotEmpty) return;

    final String rawData = await rootBundle.loadString('assets/data/pokemons.json');
    final List<dynamic> data = json.decode(rawData);

    allPokemons.clear();
    allPokemons.addAll(data.map((e) => Pokemon.fromJson(e)).toList());
  }

  List<String> get allNames => allPokemons.map((p) => p.name.toLowerCase()).toList();

  bool isValidName(String name) {
    return allNames.contains(name.toLowerCase());
  }

  Future<Pokemon> getRandomPokemon() async {
    if (allPokemons.isEmpty) {
      await fetchFirstGeneration();
    }
    allPokemons.shuffle();
    return allPokemons.first;
  }
}

