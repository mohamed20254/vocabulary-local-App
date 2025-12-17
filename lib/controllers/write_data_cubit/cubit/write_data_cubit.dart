import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary/core/constant/hive_constants.dart';
import 'package:vocabulary/model/word_model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());
  String text = '';
  bool isArabic = true;
  int colorCode = 0xff025462;

  final Box box = Hive.box(HiveConstants.wordsBox);

  //updateText
  void addtext({required final String text}) {
    this.text = text;
  }

  //  update isArabic
  void updateIsArabic(final bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitial());
  }

  //update ColorsCode
  void updateColorCode(final int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

  bool iswordhaveDatabase() {
    final List<WordModel> words = _getWordsFromDataBAse;
    for (var i = 0; i < words.length; i++) {
      if (words[i].text == text) {
        return true;
      }
    }
    return false;
  }

  //======add Word
  void addWord() {
    _handelThisCubit(() {
      final words = _getWordsFromDataBAse;
      words.add(
        WordModel(
          indexOfDataBase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode,
        ),
      );

      box.put(HiveConstants.wordList, words);
    });
  }

  //============remove Word
  void removeWord(final int index) {
    _handelThisCubit(() {
      final List<WordModel> words = _getWordsFromDataBAse;
      words.removeAt(index);
      for (var i = 0; i < words.length; i++) {
        words[i] = words[i].decrmentIndex();
      }
      box.put(HiveConstants.wordList, words);
    });
  }

  //===============addSimier Word
  void addSimilerWord(final int index) {
    _handelThisCubit(() {
      final List<WordModel> words = _getWordsFromDataBAse;
      words[index] = words[index].addSimilerWrord(
        similerWord: text,
        isArabic: isArabic,
      );
      box.put(HiveConstants.wordList, words);
    });
  }

  //remvoe similerWord
  void removeSimilerWord(
    final int indexaAtDAtaBase, {
    required final int index,
  }) {
    _handelThisCubit(() {
      final List<WordModel> words = _getWordsFromDataBAse;
      words[indexaAtDAtaBase] = words[indexaAtDAtaBase].deletsimilerWord(
        isArabic: isArabic,
        index: index,
      );

      box.put(HiveConstants.wordList, words);
    });
  }

  //----------------addExample

  void addExample(final int indexAtDataBase) {
    _handelThisCubit(() {
      final List<WordModel> words = _getWordsFromDataBAse;

      words[indexAtDataBase] = words[indexAtDataBase].addExapmle(
        isArabicExample: isArabic,
        example: text,
      );
      box.put(HiveConstants.wordList, words);
    });
  }

  //==================remove Example
  void removeExample({
    required final int indexAtDatabase,
    required final int index,
  }) {
    _handelThisCubit(() {
      final List<WordModel> words = _getWordsFromDataBAse;
      words[indexAtDatabase] = words[indexAtDatabase].removeExample(
        isArabicExample: isArabic,
        index: index,
      );
      box.put(HiveConstants.wordList, words);
    });
  }

  // handel writeData Cubit
  void _handelThisCubit(final VoidCallback methodOpration) {
    emit(WriteDataLoadngState());

    try {
      methodOpration.call();
      emit(WriteDataFinishState());
    } catch (e) {
      emit(WriteDataFailure(message: e.toString()));
    }
  }

  List<WordModel> get _getWordsFromDataBAse => List.from(
    box.get(HiveConstants.wordList, defaultValue: []),
  ).cast<WordModel>();
}
