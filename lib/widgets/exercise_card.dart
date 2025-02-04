import 'package:flutter/material.dart';
import 'package:flutter_workout_app/models/exercise.dart';
import 'package:flutter_workout_app/widgets/set_row.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final List<TextEditingController> controllers;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercise.sets,
              itemBuilder: (context, setIndex) {
                return SetRow(
                  setIndex: setIndex,
                  controller: controllers[setIndex],
                  reps: exercise.reps,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}