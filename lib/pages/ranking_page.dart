import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/game/score_service.dart';
import '../models/score.dart';
import '../components/score_tile.dart';
import '../components/header_back.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final ScoreService _scoreService = ScoreService();
  List<Score> _scores = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final scores = await _scoreService.getTopScores();
      setState(() {
        _scores = scores;
        _loading = false;
      });
    } catch (e) {
      debugPrint("RankingPage: error al cargar scores -> $e");
      setState(() {
        _scores = [];
        _loading = false;
        _error = "No se pudieron cargar los rankings.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // No background hardcodeado: usa el background del Theme (como en HomePage)
      appBar: const HeaderBack(title: "Ranking"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    )
                  : _error != null
                      ? Center(
                          child: FadeIn(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _error!,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.primary,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: _loadScores,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Reintentar",
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadScores,
                          color: colorScheme.primary,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            itemCount: _scores.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: FadeInDown(
                                    child: Center(
                                      child: Text(
                                        "🏆 Top jugadores 🏆",
                                        style:
                                            textTheme.headlineSmall?.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final score = _scores[index - 1];
                              return FadeInUp(
                                delay: Duration(milliseconds: 100 * index),
                                child: ScoreTile(score: score, rank: index),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
