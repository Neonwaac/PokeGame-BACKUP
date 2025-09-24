// lib/pages/pokedle_page.dart
import 'package:flutter/material.dart';
import 'package:pokegame/components/guess_input.dart';
import 'package:pokegame/pages/game_result_page.dart';
import '../components/header_back.dart';
import '../components/custom_button.dart';
import '../components/letter_box.dart';
import '../services/game/pokedle_service.dart';
import '../models/pokemon.dart';
import '../services/game/score_service.dart';

// feedback enum
enum FeedbackState { correct, present, absent }

List<FeedbackState> computeFeedback(String guess, String target) {
  guess = guess.toLowerCase();
  target = target.toLowerCase();
  final int n = target.length;
  final List<FeedbackState> result = List.filled(n, FeedbackState.absent);
  final List<bool> matched = List.filled(n, false);

  // primero marcamos las correctas
  for (int i = 0; i < n; i++) {
    if (i < guess.length && guess[i] == target[i]) {
      result[i] = FeedbackState.correct;
      matched[i] = true;
    }
  }

  // contamos las letras que no se usaron
  final Map<String, int> counts = {};
  for (int i = 0; i < n; i++) {
    if (!matched[i]) {
      final ch = target[i];
      counts[ch] = (counts[ch] ?? 0) + 1;
    }
  }

  // revisamos las presentes
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
  final List<String> _guesses = [];
  final TextEditingController _controller = TextEditingController();
  bool _gameOver = false;
  bool _isWin = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  Future<void> _initGame() async {
    await _service.fetchFirstGeneration();
    final poke = await _service.getRandomPokemon();
    setState(() {
      _pokemon = poke;
      _guesses.clear();
      _gameOver = false;
      _isWin = false;
    });
  }

  void _checkGuess() async {
    if (_pokemon == null || _gameOver) return;

    final guess = _controller.text.trim().toLowerCase();
    if (guess.isEmpty) return;

    final target = _pokemon!.name.toLowerCase();

    // validar longitud
    if (guess.length != target.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El nombre debe tener ${target.length} letras')),
      );
      return;
    }

    // validar existencia
    if (!_service.isValidName(guess)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese Pokémon no existe (revisa la ortografía)')),
      );
      return;
    }

    final bool isCorrect = guess == target;

    setState(() {
      _guesses.add(guess);
      if (isCorrect) {
        _isWin = true;
        _gameOver = true;
      } else if (_guesses.length >= 6) {
        _gameOver = true;
      }
      _controller.clear();
    });

    final int attempt = _guesses.length;
    if (isCorrect || _gameOver) {
      int points = 0;
      if (isCorrect) {
        points = 7 - attempt; // 6 -> 1 punto
      }

      try {
        final prev = await ScoreService().getUserScore();
        await ScoreService().addScore(points: points);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                GameResultPage(previousScore: prev, gainedScore: points),
          ),
        );
      } catch (e) {
        debugPrint("Error al guardar score o navegar: $e");
      }
    }
  }

  Widget _buildWordRow(String guess) {
    final target = _pokemon!.name.toLowerCase();
    final feedback = computeFeedback(guess, target);
    final int letters = target.length;

    final double availableWidth = MediaQuery.of(context).size.width - 48;
    final double spacing = 8.0;
    double tileSize = (availableWidth - (letters - 1) * spacing) / letters;
    tileSize = tileSize.clamp(28.0, 56.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(letters, (i) {
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

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: LetterBox(letter: letter, state: state, size: tileSize),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const HeaderBack(title: 'Pokedle'),
      body: _pokemon == null
          ? Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index < _guesses.length) {
                            return _buildWordRow(_guesses[index]);
                          } else {
                            return _buildWordRow('');
                          }
                        },
                      ),
                    ),
                    if (_gameOver)
                      AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(milliseconds: 600),
                        child: Column(
                          children: [
                            Text(
                              _isWin
                                  ? '¡Adivinaste! Era ${_pokemon!.name}'
                                  : 'Perdiste. El Pokémon era ${_pokemon!.name}',
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Image.network(_pokemon!.imageUrl, height: 200),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),

                    // Autocomplete
                    GuessInput(
                      controller: _controller,
                      options: _service.allPokemons,
                      hint: 'Escribe el nombre del Pokémon',
                      onFieldSubmitted: (_) => _checkGuess(),
                      onSelected: (pokemon) {
                        _controller.text = pokemon.name;
                      },
                    ),

                    const SizedBox(height: 12),
                    CustomButton(text: 'Probar', onTap: _checkGuess),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
    );
  }
}


