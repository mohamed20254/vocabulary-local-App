import 'package:hive/hive.dart';
import 'package:vocabulary/model/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  read(final BinaryReader reader) {
    return WordModel(
      colorCode: reader.readInt(),
      isArabic: reader.readBool(),
      indexOfDataBase: reader.readInt(),
      text: reader.readString(),
      arabicExamples: reader.readStringList(),
      arabicSimilarWords: reader.readStringList(),
      englisExamples: reader.readStringList(),
      englishSmiliarWords: reader.readStringList(),
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(final BinaryWriter writer, final WordModel obj) {
    writer.writeInt(obj.colorCode);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.indexOfDataBase);
    writer.writeString(obj.text);
    writer.writeStringList(obj.arabicExamples);
    writer.writeStringList(obj.englisExamples);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishSmiliarWords);
  }
}
