import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_workout_app/models/completed_workout.dart';
import 'package:flutter_workout_app/screens/home_screen.dart';
import 'package:flutter_workout_app/services/completed_workout_service.dart';
import 'package:logging/logging.dart';
import '../models/workout_template.dart';

class WorkoutStartScreen extends StatefulWidget {
  final WorkoutTemplate workout;

  const WorkoutStartScreen({super.key, required this.workout});

  @override
  WorkoutStartScreenState createState() => WorkoutStartScreenState();
}

class WorkoutStartScreenState extends State<WorkoutStartScreen> {
  final Logger _logger = Logger('WorkoutStartScreen');
  final Map<String, List<TextEditingController>> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var exercise in widget.workout.exercises) {
      _controllers[exercise.name] = List.generate(
        exercise.sets,
        (index) => TextEditingController(text: exercise.reps.toString()),
      );
    }
  }

  @override
  void dispose() {
    for (var controllers in _controllers.values) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _saveCompletedWorkout() async {
    final completedWorkout = CompletedWorkout(
      id: widget.workout.title + DateTime.now().toIso8601String(),
      title: widget.workout.title,
      completedAt: DateTime.now(),
      exercises: widget.workout.exercises.map((exercise) {
        final reps = _controllers[exercise.name]!
            .map((controller) => int.tryParse(controller.text) ?? exercise.reps)
            .toList();
        return exercise.copyWith(reps: reps.isNotEmpty ? reps[0] : null);
      }).toList(),
    );

    final service = CompletedWorkoutService();

    try {
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

  void _showFinishWorkoutDialog() {
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

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_hide),
            onPressed: _hideKeyboard,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: widget.workout.exercises.length,
            itemBuilder: (context, index) {
              final exercise = widget.workout.exercises[index];
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Text('Set ${setIndex + 1}'),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: _controllers[exercise.name]![setIndex],
                                    keyboardType: const TextInputType.numberWithOptions(
                                      signed: false,
                                      decimal: false,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: _hideKeyboard,
                                    decoration: InputDecoration(
                                      labelText: 'Reps',
                                      hintText: exercise.reps.toString(),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFinishWorkoutDialog,
        child: const Icon(Icons.check),
      ),
    );
  }
}
