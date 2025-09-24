// lib/models/score.dart
class Score {
  final String id;
  final String userId;
  final String? email;
  final int score;

  Score({
    required this.id,
    required this.userId,
    this.email,
    required this.score,
  });

  factory Score.fromFirestore(Map<String, dynamic> data, String id) {
    return Score(
      id: id,
      userId: data['userId'] ?? '',
      email: data['email'],
      score: data['score'] ?? 0,
    );
  }
}
