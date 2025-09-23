class Score {
  final String userId;
  final int score;
  final DateTime timestamp;

  Score({
    required this.userId,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "score": score,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      userId: json['userId'],
      score: json['score'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
