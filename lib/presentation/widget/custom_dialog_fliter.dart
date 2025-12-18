import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';

class CustomDialogFliter extends StatefulWidget {
  const CustomDialogFliter({super.key});

  @override
  State<CustomDialogFliter> createState() => _CustomDialogFliterState();
}

class _CustomDialogFliterState extends State<CustomDialogFliter> {
  final ValueNotifier<SortingType?> _sortingType = ValueNotifier<SortingType?>(
    null,
  );
  final ValueNotifier<SortedBy?> _sortednotifier = ValueNotifier<SortedBy?>(
    null,
  );

  @override
  Widget build(final BuildContext context) {
    log("=============================");

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            //====================================LANGUAGE FIILTER
            Text("language", style: Theme.of(context).textTheme.titleSmall),
            _buildSectionLang(context),
            const SizedBox(height: 10),
            /* 
         =============================================SOTRED BY
            */
            Text("Sotred By", style: Theme.of(context).textTheme.titleSmall),

            _buildSectionSorted(),
            const SizedBox(height: 10),
            //
            //  ====================SORTING tYPE
            //
            Text(
              "Sotreing Type",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            _buildSectionSortegType(),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<SortedBy?> _buildSectionSorted() {
    return ValueListenableBuilder(
      valueListenable: _sortednotifier,
      builder: (final context, final value, final child) {
        return Row(
          children: [
            const SizedBox(width: 10),
            _buildsectionCard(
              context,
              iscolor: context.read<ReadDataCubit>().sortedBy == SortedBy.time,
              ontap: () {
                context.read<ReadDataCubit>().updateSortedBy(SortedBy.time);
                _sortednotifier.value = SortedBy.time;
              },
              text: "Time",
            ),
            _buildsectionCard(
              context,
              iscolor:
                  context.read<ReadDataCubit>().sortedBy == SortedBy.wordLength,
              ontap: () {
                context.read<ReadDataCubit>().updateSortedBy(
                  SortedBy.wordLength,
                );
                _sortednotifier.value = SortedBy.wordLength;
              },
              text: "Word Length",
            ),
          ],
        );
      },
    );
  }

  ValueListenableBuilder<SortedBy?> _buildSectionSortegType() {
    return ValueListenableBuilder(
      valueListenable: _sortednotifier,
      builder: (final context, final value, final child) {
        return Row(
          children: [
            const SizedBox(width: 10),
            _buildsectionCard(
              context,
              iscolor:
                  context.read<ReadDataCubit>().sortingType ==
                  SortingType.ascending,
              ontap: () {
                context.read<ReadDataCubit>().updateSortingType(
                  SortingType.ascending,
                );
                _sortingType.value = SortingType.ascending;
              },
              text: "Ascending",
            ),
            _buildsectionCard(
              context,
              iscolor:
                  context.read<ReadDataCubit>().sortingType ==
                  SortingType.descending,
              ontap: () {
                context.read<ReadDataCubit>().updateSortingType(
                  SortingType.descending,
                );
                _sortingType.value = SortingType.descending;
              },
              text: "Descending",
            ),
          ],
        );
      },
    );
  }

  Row _buildSectionLang(final BuildContext context) {
    return Row(
      children: [
        _buildsectionCard(
          context,
          text: "allWords",
          iscolor:
              context.read<ReadDataCubit>().languageFilter ==
              LanguageFilter.allWords,
          ontap: () {
            context.read<ReadDataCubit>().updateLanguageFilter(
              LanguageFilter.allWords,
            );
            setState(() {});
          },
        ),
        _buildsectionCard(
          context,
          text: "arabic",
          iscolor:
              context.read<ReadDataCubit>().languageFilter ==
              LanguageFilter.arabicOnly,
          ontap: () {
            context.read<ReadDataCubit>().updateLanguageFilter(
              LanguageFilter.arabicOnly,
            );
            setState(() {});
          },
        ),

        _buildsectionCard(
          context,
          text: "english",
          iscolor:
              context.read<ReadDataCubit>().languageFilter ==
              LanguageFilter.englishOnly,
          ontap: () {
            context.read<ReadDataCubit>().updateLanguageFilter(
              LanguageFilter.englishOnly,
            );
            setState(() {});
          },
        ),
      ],
    );
  }

  InkWell _buildsectionCard(
    final BuildContext context, {
    required final bool iscolor,
    required final VoidCallback ontap,
    required final String text,
  }) {
    return InkWell(
      onTap: ontap,
      child: Card(
        color: iscolor ? const Color.fromARGB(255, 16, 99, 240) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(text),
        ),
      ),
    );
  }
}
