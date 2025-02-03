import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_workout_app/models/completed_workout.dart';
import 'package:flutter_workout_app/screens/home_screen.dart';
import 'package:flutter_workout_app/services/completed_workout_service.dart';
import 'package:logging/logging.dart';
import '../models/workout_template.dart';
import '../../models/exercise.dart';

class WorkoutStartScreen extends StatefulWidget {
  final WorkoutTemplate workout;

  const WorkoutStartScreen({super.key, required this.workout});

  @override
  WorkoutStartScreenState createState() => WorkoutStartScreenState();
}

class WorkoutStartScreenState extends State<WorkoutStartScreen> {
  final Logger _logger = Logger('WorkoutStartScreen');

  void _saveCompletedWorkout() async {
    final completedWorkout = CompletedWorkout(
      id: widget.workout.title + DateTime.now().toIso8601String(),
      title: widget.workout.title,
      completedAt: DateTime.now(),
      exercises: widget.workout.exercises, // Modify if needed for reps/sets
    );

    final service = CompletedWorkoutService();

    try {
      _logger.info('Attempting to save workout');
      await service.saveCompletedWorkout(completedWorkout).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('The save operation timed out');
        },
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout saved successfully!')),
      );
      _logger.info('Workout saved successfully, navigating to HomeScreen');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save workout: $error')),
      );
      _logger.severe('Error saving workout: $error');
    }
  }

  void _showFinishWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Finish Workout"),
          content: const Text(
              "Are you sure you want to finish and save this workout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logger.info('Finish & Save pressed');
                _saveCompletedWorkout(); // Call save method
              },
              child: const Text("Finish & Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perform ${widget.workout.title}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.workout.exercises.length,
                itemBuilder: (context, index) {
                  final Exercise exercise = widget.workout.exercises[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
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
                        const SizedBox(height: 4),
                        Text(
                          "Reps: ${exercise.reps}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Sets: ${exercise.sets}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _showFinishWorkoutDialog(context),
              child: const Text('Finish Workout'),
            ),
          ],
        ),
      ),
    );
  }
}