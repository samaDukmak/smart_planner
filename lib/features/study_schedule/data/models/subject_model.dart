// features/study_schedule/data/models/subject_model.dart

class SubjectModel {
  final String name;
  final double difficulty;
  final double understanding;

  SubjectModel({
    required this.name,
    required this.difficulty,
    required this.understanding,
  });

  Map<String, dynamic> toJson() => {
        'name'          : name,
        // يحوّل إلى integer كما يتوقع الباك-إند
        'difficulty'    : difficulty.toInt(),
        'understanding' : understanding.toInt(),
      };
}
