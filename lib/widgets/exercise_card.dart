import 'package:flutter/material.dart';

class ExerciseCardWithRepsSets extends StatelessWidget {
  final String name;
  final String description;
  final String equipment;
  final String targetBodyPart;
  final String exerciseType;
  final int reps;
  final int sets;

  const ExerciseCardWithRepsSets({
    super.key,
    required this.name,
    required this.description,
    required this.equipment,
    required this.targetBodyPart,
    required this.exerciseType,
    required this.reps,
    required this.sets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.fitness_center, size: 30),
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("$targetBodyPart - $exerciseType\nReps: $reps, Sets: $sets"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to exercise detail if needed
        },
      ),
    );
  }
}
