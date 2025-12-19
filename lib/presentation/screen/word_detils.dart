import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_state.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabulary/model/word_model.dart';
import 'package:vocabulary/presentation/widget/custom_bottom_sheet.dart';
import 'package:vocabulary/presentation/widget/custom_remov.dart';

class WordDetils extends StatefulWidget {
  final WordModel word;
  const WordDetils({super.key, required this.word});

  @override
  State<WordDetils> createState() => _WordDetilsState();
}

class _WordDetilsState extends State<WordDetils> {
  final TextEditingController controler = TextEditingController();
  late WordModel word;
  @override
  void initState() {
    word = widget.word;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),

      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (final context, final state) {
          final indexword = (state as ReadDataCubitSuccessState).words
              .indexWhere(
                (final element) =>
                    element.indexOfDataBase == widget.word.indexOfDataBase,
              );
          word = (state as ReadDataCubitSuccessState).words[indexword];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "word",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  CustomContainer(
                    isArabic: word.isArabic,
                    text: word.text,
                    colorcode: word.colorCode,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Similer Word",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            showModelButtomSheet(
                              context,
                              labeltext: "add Similer Word",
                              controler: controler,
                              ontap: () {
                                context.read<WriteDataCubit>().addtext(
                                  text: controler.text,
                                );

                                context.read<WriteDataCubit>().addSimilerWord(
                                  word.indexOfDataBase,
                                );
                                context.read<ReadDataCubit>().getWords();
                              },
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),

                  ///=====================arabic similer word
                  Column(
                    children: List.generate(
                      word.arabicSimilarWords.length,
                      (final index) => custom_remove_elemrnt(
                        widget: widget,
                        isarabic: true,
                        ontap: () {
                          context.read<WriteDataCubit>().updateIsArabic(true);
                          context.read<WriteDataCubit>().removeSimilerWord(
                            word.indexOfDataBase,
                            index: index,
                          );
                        },
                        text: word.arabicSimilarWords[index],
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      word.englishSmiliarWords.length,
                      (final index) => custom_remove_elemrnt(
                        widget: widget,
                        isarabic: false,
                        ontap: () {
                          context.read<WriteDataCubit>().updateIsArabic(false);
                          context.read<WriteDataCubit>().removeSimilerWord(
                            word.indexOfDataBase,
                            index: index,
                          );
                        },
                        text: word.englishSmiliarWords[index],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "example",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            controler.clear();
                            showModelButtomSheet(
                              context,
                              labeltext: "add example",
                              controler: controler,
                              ontap: () {
                                context.read<WriteDataCubit>().addtext(
                                  text: controler.text,
                                );

                                context.read<WriteDataCubit>().addExample(
                                  word.indexOfDataBase,
                                );
                                context.read<ReadDataCubit>().getWords();
                              },
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),

                  ///=====================arabic similer word
                  Column(
                    children: List.generate(
                      word.arabicExamples.length,
                      (final index) => custom_remove_elemrnt(
                        widget: widget,
                        isarabic: true,
                        ontap: () {
                          context.read<WriteDataCubit>().updateIsArabic(true);
                          context.read<WriteDataCubit>().removeExample(
                            indexAtDatabase: word.indexOfDataBase,
                            index: index,
                          );
                        },
                        text: word.arabicExamples[index],
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      word.englisExamples.length,
                      (final index) => custom_remove_elemrnt(
                        widget: widget,
                        isarabic: false,
                        ontap: () {
                          context.read<WriteDataCubit>().updateIsArabic(false);
                          context.read<WriteDataCubit>().removeExample(
                            indexAtDatabase: word.indexOfDataBase,
                            index: index,
                          );
                        },
                        text: word.englisExamples[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppbar(final BuildContext context) {
    return AppBar(
      title: const Text("Word  details"),
      actions: [
        IconButton(
          onPressed: () {
            context.read<WriteDataCubit>().removeWord(
              widget.word.indexOfDataBase,
            );
            Navigator.pop(context);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}
