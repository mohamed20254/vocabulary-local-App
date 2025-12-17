import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  final bool isArabic;
  const ArabicOrEnglishWidget({super.key, required this.isArabic});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          _buildContaner(
            context,
            color: isArabic ? Colors.white : Colors.transparent,
            text: "ar",
            colorText: isArabic ? Colors.black : Colors.white,
            onTap: () {
              context.read<WriteDataCubit>().updateIsArabic(true);
            },
          ),
          _buildContaner(
            context,
            color: !isArabic ? Colors.white : Colors.transparent,
            text: "en",
            colorText: !isArabic ? Colors.black : Colors.white,
            onTap: () {
              context.read<WriteDataCubit>().updateIsArabic(false);
            },
          ),
        ],
      ),
    );
  }

  InkWell _buildContaner(
    final BuildContext context, {
    required final Color color,
    required final String text,
    required final Color colorText,
    required final void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(color: colorText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
