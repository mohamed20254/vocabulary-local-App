import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabulary/core/constant/common/custom_text_form_field.dart';
import 'package:vocabulary/presentation/widget/arabic_or_english_widget.dart';

void showModelButtomSheet(
  final BuildContext context, {
  required final String labeltext,
  required final VoidCallback ontap,
  required final TextEditingController controler,
}) {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    builder: (final context) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Align(
                child: Text(
                  labeltext,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<WriteDataCubit, WriteDataState>(
                builder: (final context, final state) {
                  return ArabicOrEnglishWidget(
                    isArabic: context.read<WriteDataCubit>().isArabic,
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                validator: (final value) {
                  if (value == null || value.isEmpty) {
                    return "required";
                  }
                  return null;
                },

                controler: controler,
                labelText: labeltext,
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ontap.call();
                    }
                  },
                  child: Text(
                    "add",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
