class WordModel {
  final int indexOfDataBase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSmiliarWords;
  final List<String> arabicExamples;
  final List<String> englisExamples;

  WordModel({
    required this.indexOfDataBase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWords = const [],
    this.englishSmiliarWords = const [],
    this.arabicExamples = const [],
    this.englisExamples = const [],
  });
}
