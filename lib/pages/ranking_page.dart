import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/game/score_service.dart';
import '../models/score.dart';
import '../components/score_tile.dart';
import '../components/header_back.dart';
import '../themes/palette.dart';

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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.purpleDark, AppColors.primaryPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const HeaderBack(title: "Ranking"),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentGreen,
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
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontFamily: 'PixelifySans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: _loadScores,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accentGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Reintentar",
                                    style: TextStyle(
                                      fontFamily: 'PixelifySans',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadScores,
                          color: AppColors.accentGreen,
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
                                        style: const TextStyle(
                                          fontFamily: 'PixelifySans',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
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