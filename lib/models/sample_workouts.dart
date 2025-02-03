import 'workout_template.dart';
import 'sample_exercises.dart';

final List<WorkoutTemplate> sampleWorkouts = [
  WorkoutTemplate(
    title: "Full Body Blast",
    description: "A workout designed to target your entire body.",
    exercises: [
      sampleExercises[0].withRepsAndSets(15, 3), // Push-Up
      sampleExercises[1].withRepsAndSets(20, 3), // Kettlebell Swing
      sampleExercises[2].withRepsAndSets(30, 3), // Plank
    ],
    estimatedDuration: 10, 
    id: '',
  ),
  WorkoutTemplate(
    title: "Core Strength",
    description: "Strengthen your core with these exercises.",
    exercises: [
      sampleExercises[2].withRepsAndSets(40, 3), // Plank
    ],
    estimatedDuration: 5,
    id: '',
  ),
];
