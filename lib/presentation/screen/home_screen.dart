import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_state.dart';
import 'package:vocabulary/core/constant/common/failure_widget.dart';
import 'package:vocabulary/core/constant/common/loading_widget.dart';
import 'package:vocabulary/presentation/screen/word_detils.dart';
import 'package:vocabulary/presentation/widget/custom_dialog_fliter.dart';

import 'package:vocabulary/presentation/widget/dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final duration) {
      context.read<ReadDataCubit>().getWords();
    });

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: _buildFloatactionBuuton(context),

      appBar: AppBar(title: const Text("Words")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
          builder: (final context, final state) {
            if (state is ReadDataCubitLoadingState) {
              return const LodingScreen();
            } else if (state is ReadDataCubitFailedState) {
              return FailureScreen(
                text: state.message,
                ontap: () {
                  context.read<ReadDataCubit>().getWords();
                },
              );
            }

            if (state is ReadDataCubitSuccessState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        context.read<ReadDataCubit>().languageFilter ==
                                LanguageFilter.allWords
                            ? "allwords"
                            : context.read<ReadDataCubit>().languageFilter ==
                                  LanguageFilter.englishOnly
                            ? "engilsh words"
                            : "arabic Words",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.read<ReadDataCubit>().sortedBy == SortedBy.time
                            ? "(Time)"
                            : "(word lenguth)",

                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.read<ReadDataCubit>().sortingType ==
                                SortingType.ascending
                            ? "(ascending)"
                            : "(descending)",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (final context) =>
                              const CustomDialogFliter(),
                        ),
                        icon: const Icon(Icons.filter_list_outlined),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: state.words.length,
                      itemBuilder: (final context, final index) {
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (final context) =>
                                  WordDetils(word: state.words[index]),
                            ),
                          ),
                          child: Card(
                            color: Color(state.words[index].colorCode),
                            child: Center(
                              child: Text(
                                state.words[index].text,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatactionBuuton(final BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (final context) => const Center(child: DialogWidget()),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
