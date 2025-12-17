import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.currentColorCode});
  final int currentColorCode;
  @override
  Widget build(final BuildContext context) {
    final List<int> colors = [
      0xff025462,
      0xFFE53935,
      0xFFD81B60,
      0xFF8E24AA,
      0xFF5E35B1,
      0xFF3949AB,
      0xFF1E88E5,
      0xFF039BE5,
      0xFF00ACC1,
      0xFF43A047,
      0xFFFDD835,
    ];
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: colors.length,
        itemBuilder: (final context, final index) {
          return InkWell(
            onTap: () {
              context.read<WriteDataCubit>().updateColorCode(colors[index]);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(colors[index]),
                border: currentColorCode == colors[index]
                    ? Border.all(color: Colors.white, width: 2)
                    : null,
                shape: BoxShape.circle,
              ),
              child: currentColorCode == colors[index]
                  ? const Icon(Icons.done)
                  : null,
            ),
          );
        },
        separatorBuilder: (final context, final index) =>
            const SizedBox(width: 5),
      ),
    );
  }
}
