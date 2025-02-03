import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/completed_workout.dart';

class CompletedWorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveCompletedWorkout(CompletedWorkout completedWorkout) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is signed in');
    }

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('completed_workouts')
        .doc(completedWorkout.id);

    try {
      await docRef.set(completedWorkout.toMap());
    } catch (error) {
      throw Exception('Failed to save completed workout: $error');
    }
  }

  Future<List<CompletedWorkout>> fetchCompletedWorkouts() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is signed in');
    }

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('completed_workouts')
          .get();
      return querySnapshot.docs.map((doc) {
        return CompletedWorkout.fromMap(doc.data());
      }).toList();
    } catch (error) {
      throw Exception('Failed to fetch completed workouts: $error');
    }
  }
}
