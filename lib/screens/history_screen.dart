import 'package:flutter/material.dart';
import 'package:flutter_workout_app/models/completed_workout.dart';
import 'package:flutter_workout_app/services/completed_workout_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final CompletedWorkoutService _service = CompletedWorkoutService();
  late Future<List<CompletedWorkout>> _completedWorkouts;

  @override
  void initState() {
    super.initState();
    _completedWorkouts = _service.fetchCompletedWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: FutureBuilder<List<CompletedWorkout>>(
        future: _completedWorkouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No completed workouts found.'));
          } else {
            final workouts = snapshot.data!;
            return ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return ListTile(
                  title: Text(workout.title),
                  subtitle: Text('Completed at: ${workout.completedAt}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}