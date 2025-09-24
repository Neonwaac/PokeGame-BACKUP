import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/score.dart';

class ScoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addScore({required int points}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("No hay usuario autenticado");
    }

    final docRef = _db.collection("scores").doc(user.uid);

    try {
      await _db.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (snapshot.exists) {
          final prevScore = snapshot.data()?["score"] ?? 0;
          final newScore = (prevScore is int)
              ? prevScore + points
              : int.tryParse(prevScore.toString()) ?? points;

          transaction.update(docRef, {
            "score": newScore,
            "updatedAt": FieldValue.serverTimestamp(),
          });
        } else {
          transaction.set(docRef, {
            "userId": user.uid,
            "email": user.email,
            "score": points,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp(),
          });
        }
      });
      print("ScoreService: addScore exitoso para ${user.uid} (+$points)");
    } catch (e, st) {
      print("ScoreService: error en addScore -> $e");
      print(st.toString());
      rethrow;
    }
  }

  Future<int> getUserScore() async {
    final user = _auth.currentUser;
    if (user == null) return 0;

    try {
      final snapshot = await _db.collection("scores").doc(user.uid).get();
      if (snapshot.exists) {
        final data = snapshot.data();
        final score = data?["score"];
        if (score is int) return score;
        return int.tryParse(score.toString()) ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print("ScoreService: error en getUserScore -> $e");
      return 0;
    }
  }

  /// Devuelve los mejores scores en orden descendente.
  /// Si hay un error, devuelve lista vacía y lo registra.
  Future<List<Score>> getTopScores({int limit = 20}) async {
    try {
      final query = await _db
          .collection("scores")
          .orderBy("score", descending: true)
          .limit(limit)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        return Score(
          id: doc.id,
          userId: data["userId"] ?? doc.id,
          email: data["email"] ?? '',
          score: (data["score"] ?? 0) is int
              ? data["score"]
              : int.tryParse(data["score"].toString()) ?? 0,
        );
      }).toList();
    } catch (e, st) {
      print("ScoreService: error en getTopScores -> $e");
      print(st.toString());
      return [];
    }
  }
}
