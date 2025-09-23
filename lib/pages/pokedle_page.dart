// lib/pages/pokedle_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/header_back.dart';
import '../components/custom_button.dart';
import '../components/letter_box.dart';
import '../components/pokemon_autocomplete_field.dart';
import '../services/game/pokedle_service.dart';
import '../models/pokemon.dart';
import '../themes/palette.dart';

// feedback enum
enum FeedbackState { correct, present, absent }

List<FeedbackState> computeFeedback(String guess, String target) {
  guess = guess.toLowerCase();
  target = target.toLowerCase();
  final int n = target.length;
  final List<FeedbackState> result = List.filled(n, FeedbackState.absent);
  final List<bool> matched = List.filled(n, false);

  for (int i = 0; i < n; i++) {
    if (i < guess.length && guess[i] == target[i]) {
      result[i] = FeedbackState.correct;
      matched[i] = true;
    }
  }

  final Map<String,int> counts = {};
  for (int i = 0; i < n; i++) {
    if (!matched[i]) {
      final ch = target[i];
      counts[ch] = (counts[ch] ?? 0) + 1;
    }
  }

  for (int i = 0; i < n; i++) {
    if (result[i] == FeedbackState.correct) continue;
    if (i >= guess.length) {
      result[i] = FeedbackState.absent;
      continue;
    }
    final ch = guess[i];
    if ((counts[ch] ?? 0) > 0) {
      result[i] = FeedbackState.present;
      counts[ch] = counts[ch]! - 1;
    } else {
      result[i] = FeedbackState.absent;
    }
  }

  return result;
}

class PokedlePage extends StatefulWidget {
  const PokedlePage({super.key});

  @override
  State<PokedlePage> createState() => _PokedlePageState();
}

class _PokedlePageState extends State<PokedlePage> {
  final PokedleService _service = PokedleService();
  Pokemon? _pokemon;
  List<String> _guesses = [];
  final TextEditingController _controller = TextEditingController();
  bool _gameOver = false;
  bool _isWin = false;
  List<String> _allNames = [];

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  Future<void> _initGame() async {
    await _service.fetchFirstGeneration();
    _allNames = _service.allNames; // nombres en minúscula
    final poke = await _service.getRandomPokemon();
    setState(() {
      _pokemon = poke;
      _guesses.clear();
      _gameOver = false;
      _isWin = false;
    });
  }

  void _checkGuess() {
    if (_pokemon == null || _gameOver) return;

    final guess = _controller.text.trim().toLowerCase();
    if (guess.isEmpty) return;

    // 1) validar longitud
    final target = _pokemon!.name.toLowerCase();
    if (guess.length != target.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El nombre debe tener ${target.length} letras')),
      );
      return;
    }

    // 2) validar que exista en la lista
    if (!_service.isValidName(guess)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese Pokémon no existe (revisa la ortografía)')),
      );
      return;
    }

    setState(() {
      _guesses.add(guess);
      if (guess == target) {
        _isWin = true;
        _gameOver = true;
      } else if (_guesses.length >= 6) {
        _gameOver = true;
      }
      _controller.clear();
    });
  }

  Widget _buildWordRow(String guess) {
    final target = _pokemon!.name.toLowerCase();
    final feedback = computeFeedback(guess, target);
    final int letters = target.length;

    // calcular tamaño dinámico
    final double availableWidth = MediaQuery.of(context).size.width - 48; // paddings
    final double spacing = 8.0;
    double tileSize = (availableWidth - (letters - 1) * spacing) / letters;
    tileSize = tileSize.clamp(28.0, 56.0);

    List<Widget> boxes = [];
    for (int i = 0; i < letters; i++) {
      final letter = (i < guess.length) ? guess[i] : '';
      LetterState state;
      if (i < guess.length) {
        switch (feedback[i]) {
          case FeedbackState.correct:
            state = LetterState.correct;
            break;
          case FeedbackState.present:
            state = LetterState.present;
            break;
          case FeedbackState.absent:
          default:
            state = LetterState.absent;
            break;
        }
      } else {
        state = LetterState.empty;
      }

      boxes.add(LetterBox(letter: letter, state: state, size: tileSize));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: boxes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBack(title: 'Pokedle'),
      body: _pokemon == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _guesses.isEmpty ? 1 : _guesses.length,
                      itemBuilder: (context, index) {
                        if (_guesses.isEmpty) {
                          // mostrar filas vacías hasta 6 si no hay nada
                          return Column(
                            children: List.generate(6, (_) {
                              return _buildWordRow('');
                            }),
                          );
                        }
                        return _buildWordRow(_guesses[index]);
                      },
                    ),
                  ),
                  if (_gameOver)
                    Column(
                      children: [
                        Text(
                          _isWin ? '¡Correcto! Era ${_pokemon!.name}' : 'Perdiste 😢. Era ${_pokemon!.name}',
                          style: const TextStyle(fontFamily: 'PixelifySans', color: AppColors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        Image.network(_pokemon!.imageUrl, height: 120),
                      ],
                    ),
                  const SizedBox(height: 12),

                  // Autocomplete field
                  PokemonAutocompleteField(
                    controller: _controller,
                    options: _allNames,
                    hint: 'Escribe el nombre del Pokémon',
                    onFieldSubmitted: (_) => _checkGuess(),
                  ),

                  const SizedBox(height: 12),
                  CustomButton(text: 'Probar', onTap: _checkGuess),
                  const SizedBox(height: 18),
                ],
              ),
            ),
    );
  }
}
