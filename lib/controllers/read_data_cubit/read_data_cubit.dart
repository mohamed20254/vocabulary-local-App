import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_state.dart';
import 'package:vocabulary/core/constant/hive_constants.dart';
import 'package:vocabulary/model/word_model.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  static ReadDataCubit get(final context) => BlocProvider.of(context);

  ReadDataCubit() : super(ReadDataCubitInitialState());

  final Box _box = Hive.box(HiveConstants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;

  void updateLanguageFilter(final LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(final SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(final SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

  void getWords() async {
    emit(ReadDataCubitLoadingState());
    try {
      final List<WordModel> wordsToReturn = List.from(
        _box.get(HiveConstants.wordList, defaultValue: []),
      ).cast<WordModel>();
      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);
      emit(ReadDataCubitSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(
        ReadDataCubitFailedState(
          message: "We have problems at get, Please try again",
        ),
      );
    }
  }

  void _removeUnwantedWords(final List<WordModel> wordsToReturn) {
    switch (languageFilter) {
      case LanguageFilter.allWords:
        return;
      case LanguageFilter.arabicOnly:
        wordsToReturn.removeWhere((final element) => !element.isArabic);
        break;

      case LanguageFilter.englishOnly:
        wordsToReturn.removeWhere((final element) => element.isArabic);
        break;
    }
  }

  void _applySorting(final List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      }
      _reverse(wordsToReturn);
    } else {
      wordsToReturn.sort(
        (final WordModel a, final WordModel b) =>
            a.text.length.compareTo(b.text.length),
      );
      if (sortingType == SortingType.ascending) {
        return;
      }
      _reverse(wordsToReturn);
    }
  }

  void _reverse(final List<WordModel> wordsToReturn) {
    for (var i = 0; i < wordsToReturn.length / 2; i++) {
      final WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter { arabicOnly, englishOnly, allWords }

enum SortedBy { time, wordLength }

enum SortingType { ascending, descending }
