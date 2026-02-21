import 'package:FitnTrain/app/translations/phrase_model.dart';

class LocalizationModel {
  final String language;
  final List<PhraseModel> phrases;

  LocalizationModel({
    required this.language,
    required this.phrases,
  });

  factory LocalizationModel.fromMap(Map data) {
    return LocalizationModel(
      language: data['language'],
      phrases:
      (data['phrases'] as List).map((v) => PhraseModel.fromMap(v)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "language": language,
    "phrases": List<dynamic>.from(phrases.map((x) => x.toJson())),
  };
}