import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/presentation/screen/word_detils.dart';

class custom_remove_elemrnt extends StatelessWidget {
  const custom_remove_elemrnt({
    super.key,
    required this.widget,
    required this.text,
    required this.isarabic,
    required this.ontap,
  });
  final String text;
  final bool isarabic;
  final VoidCallback ontap;
  final WordDetils widget;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Delete"),
            content: const Text("are you shour delete this word"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancl",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextButton(
                  onPressed: () {
                    ontap.call();
                    context.read<ReadDataCubit>().getWords();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'delete',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: CustomContainer(
        isArabic: isarabic,
        text: text,
        colorcode: widget.word.colorCode,
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.isArabic,
    required this.text,
    required this.colorcode,
  });

  final bool isArabic;
  final String text;
  final int colorcode;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(colorcode),
            child: Text(isArabic ? "ar" : "en"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
