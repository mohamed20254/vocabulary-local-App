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

  //=========================add Smilier Word
  WordModel addSimilerWrord({
    required final String similerWord,
    required final bool isArabic,
  }) {
    final List<String> newlist = _initializedNewsimilerWord(isArabic: isArabic);
    newlist.add(similerWord);

    return _getWordafterChecksimilerWord(
      isArabic: isArabic,
      newSmiliWord: newlist,
    );
  }

  //=====================reomve Similer Word
  WordModel deletsimilerWord({
    required final bool isArabic,
    required final int index,
  }) {
    final List<String> newlist = _initializedNewsimilerWord(isArabic: isArabic);

    newlist.removeAt(index);
    return _getWordafterChecksimilerWord(
      isArabic: isArabic,
      newSmiliWord: newlist,
    );
  }

  //=================addExamples
  WordModel addExapmle({
    required final bool isArabicExample,
    required final String example,
  }) {
    final newList = _initializedNewExample(isArabiceExample: isArabicExample);
    newList.add(example);

    return _getwordAfterCheckExample(isArabic: isArabic, newExample: newList);
  }

  //==============removexample
  WordModel removeExample({
    required final bool isArabicExample,
    required final int index,
  }) {
    final newList = _initializedNewExample(isArabiceExample: isArabicExample);
    newList.removeAt(index);

    return _getwordAfterCheckExample(isArabic: isArabic, newExample: newList);
  }
  //  incrementIndexOfDataBase

  WordModel decrmentIndex() {
    return WordModel(
      indexOfDataBase: indexOfDataBase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      arabicSimilarWords: arabicSimilarWords,
      englisExamples: englisExamples,
      englishSmiliarWords: englishSmiliarWords,
    );
  }

  //========================funcation Refactor
  List<String> _initializedNewsimilerWord({required final bool isArabic}) {
    List<String> newlist = [];
    if (isArabic) {
      newlist = List.from(arabicSimilarWords);
    } else {
      newlist = List<String>.from(englishSmiliarWords);
    }
    return newlist;
  }

  WordModel _getWordafterChecksimilerWord({
    required final bool isArabic,
    required final List<String> newSmiliWord,
  }) {
    return WordModel(
      indexOfDataBase: indexOfDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      englisExamples: englisExamples,
      arabicSimilarWords: isArabic ? newSmiliWord : arabicSimilarWords,
      englishSmiliarWords: isArabic ? englishSmiliarWords : newSmiliWord,
    );
  }

  List<String> _initializedNewExample({required final bool isArabiceExample}) {
    List<String> newList = [];
    if (isArabiceExample) {
      newList = List.from(arabicExamples);
    } else {
      newList = List.from(englisExamples);
    }
    return newList;
  }

  WordModel _getwordAfterCheckExample({
    required final bool isArabic,
    required final List<String> newExample,
  }) {
    return WordModel(
      indexOfDataBase: indexOfDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: isArabic ? newExample : arabicExamples,
      englisExamples: isArabic ? englisExamples : newExample,
      arabicSimilarWords: arabicSimilarWords,
      englishSmiliarWords: englishSmiliarWords,
    );
  }
}
