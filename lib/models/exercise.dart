class Exercise {
  final String name;
  final String description;
  final String equipment;
  final String targetBodyPart;
  final String exerciseType;
  final int reps;
  final int sets;

  Exercise({
    required this.name,
    required this.description,
    required this.equipment,
    required this.targetBodyPart,
    required this.exerciseType,
    this.reps = 0,
    this.sets = 0,
  });

  Exercise withRepsAndSets(int reps, int sets) {
    return Exercise(
      name: name,
      description: description,
      equipment: equipment,
      targetBodyPart: targetBodyPart,
      exerciseType: exerciseType,
      reps: reps,
      sets: sets,
    );
  }

    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'equipment': equipment,
      'targetBodyPart': targetBodyPart,
      'exerciseType': exerciseType,
      'reps': reps,
      'sets': sets,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      description: map['description'],
      equipment: map['equipment'],
      targetBodyPart: map['targetBodyPart'],
      exerciseType: map['exerciseType'],
      reps: map['reps'],
      sets: map['sets'],
    );
  }
}