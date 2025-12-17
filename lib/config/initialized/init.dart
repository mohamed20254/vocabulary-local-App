import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary/core/constant/hive_constants.dart';
import 'package:vocabulary/model/word_type_adapter.dart';

Future<void> init() async {
  //hive
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
}
