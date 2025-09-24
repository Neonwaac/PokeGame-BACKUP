import 'package:flutter/material.dart';
import 'package:pokegame/pages/game_result_page.dart';
import '../components/header_back.dart';
import '../components/game_chip.dart';
import '../services/game/guess_type_service.dart';
import '../services/game/score_service.dart';
import '../models/pokemon.dart';
import '../models/type.dart';

class GuessTypePage extends StatefulWidget {
  const GuessTypePage({super.key});

  @override
  State<GuessTypePage> createState() => _GuessTypePageState();
}

class _GuessTypePageState extends State<GuessTypePage> {
  final GuessTypeService _service = GuessTypeService();
  Pokemon? _pokemon;
  List<PokeType> _types = [];
  final Set<String> _selectedTypes = {};
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  Future<void> _initGame() async {
    await _service.fetchTypes();
    await _service.fetchPokemons();

    final poke = await _service.getRandomPokemon();
    setState(() {
      _pokemon = poke;
      _types = _service.allTypes;
      _selectedTypes.clear();
      _gameOver = false;
    });
  }

  Future<void> _onSelectType(PokeType type) async {
    if (_gameOver) return;

    final correctTypes = {
      _pokemon!.type1,
      if (_pokemon!.type2 != null) _pokemon!.type2!,
    };

    final isCorrect = correctTypes.contains(type.name);

    setState(() {
      _selectedTypes.add(type.name);
    });

    if (isCorrect && _selectedTypes.containsAll(correctTypes)) {
      setState(() {
        _gameOver = true;
      });

      try {
        final prev = await ScoreService().getUserScore();
        await ScoreService().addScore(points: 3);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GameResultPage(previousScore: prev, gainedScore: 3),
          ),
        );
      } catch (e) {
        debugPrint("Error al guardar score o navegar en GuessType: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Ganaste! Era ${_pokemon!.name}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (!isCorrect) {
      try {
        await ScoreService().addScore(points: -1);
      } catch (e) {
        debugPrint("Error al restar punto en GuessType: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const HeaderBack(title: "¿Qué tipo es?"),
      body: _pokemon == null
          ? Center(child: CircularProgressIndicator(color: colors.primary))
          : Column(
              children: [
                const SizedBox(height: 16),

                /// Pokémon en el centro con estilo
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.network(
                    _pokemon!.imageUrl,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                /// Grid de chips
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: List.generate(_types.length, (index) {
                      final t = _types[index];
                      final isSelected = _selectedTypes.contains(t.name);
                      final correctTypes = {
                        _pokemon!.type1,
                        if (_pokemon!.type2 != null) _pokemon!.type2!,
                      };
                      final isCorrect = correctTypes.contains(t.name);

                      return SizedBox.square(
                        dimension: 70,
                        child: GameChip(
                          imageUrl: t.imageUrl,
                          isSelected: isSelected,
                          isCorrect: isCorrect,
                          onTap: () => _onSelectType(t),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
