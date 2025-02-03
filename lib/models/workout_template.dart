import 'exercise.dart';

class WorkoutTemplate {
  final String id; // Unique identifier
  final String title;
  final String description;
  final List<Exercise> exercises;
  final int estimatedDuration;

  WorkoutTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.exercises,
    required this.estimatedDuration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory WorkoutTemplate.fromMap(Map<String, dynamic> map) {
    return WorkoutTemplate(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      exercises: (map['exercises'] as List)
          .map((e) => Exercise.fromMap(e))
          .toList(),
      estimatedDuration: map['estimatedDuration'],
    );
  }
}
