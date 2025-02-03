import 'package:flutter/material.dart';
import 'package:flutter_workout_app/models/sample_workouts.dart';
import 'package:flutter_workout_app/widgets/workout_card.dart';
import 'package:flutter_workout_app/screens/workout_details_screen.dart';
import 'package:flutter_workout_app/screens/workout_start_screen.dart';
import 'package:flutter_workout_app/models/workout_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToWorkoutDetails(BuildContext context, WorkoutTemplate workout) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => WorkoutDetailScreen(workout: workout)),
    );
  }

  void _navigateToWorkoutStart(BuildContext context, WorkoutTemplate workout) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => WorkoutStartScreen(workout: workout)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Workouts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sampleWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = sampleWorkouts[index];
                  return WorkoutCard(
                    workout: workout,
                    onTap: () => _navigateToWorkoutDetails(context, workout),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
