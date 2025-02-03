import 'package:flutter/material.dart';
import 'package:flutter_workout_app/screens/workout_details_screen.dart';
import 'package:flutter_workout_app/models/workout_template.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutTemplate workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.fitness_center, size: 30),
        title: Text(workout.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("${workout.exercises.length} exercises"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WorkoutDetailScreen(workout: workout),
            ),
          );
        },
      ),
    );
  }
}
