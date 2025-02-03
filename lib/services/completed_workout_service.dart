import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/completed_workout.dart';

class CompletedWorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveCompletedWorkout(CompletedWorkout completedWorkout) async {
    final docRef =
        _firestore.collection('completed_workouts').doc(completedWorkout.id);

    try {
      await docRef.set(completedWorkout.toMap());
    } catch (error) {
      throw Exception('Failed to save completed workout: $error');
    }
  }

  Future<List<CompletedWorkout>> fetchCompletedWorkouts() async {
    try {
      final querySnapshot = await _firestore.collection('completed_workouts').get();
      return querySnapshot.docs.map((doc) {
        return CompletedWorkout.fromMap(doc.data());
      }).toList();
    } catch (error) {
      throw Exception('Failed to fetch completed workouts: $error');
    }
  }
}
