import 'exercise.dart';

class CompletedWorkout {
  final String id; // Unique identifier
  final String title;
  final DateTime completedAt;
  final List<Exercise> exercises;

  CompletedWorkout({
    required this.id,
    required this.title,
    required this.completedAt,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completedAt': completedAt.toIso8601String(),
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory CompletedWorkout.fromMap(Map<String, dynamic> map) {
    return CompletedWorkout(
      id: map['id'],
      title: map['title'],
      completedAt: DateTime.parse(map['completedAt']),
      exercises: (map['exercises'] as List)
          .map((e) => Exercise.fromMap(e))
          .toList(),
    );
  }
}
