import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/core/constant/common/custom_text_form_field.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabulary/presentation/widget/arabic_or_english_widget.dart';
import 'package:vocabulary/presentation/widget/color_widget.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<WriteDataCubit, WriteDataState>(
      builder: (final context, final state) {
        return Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: BoxDecoration(
              color: Color(context.read<WriteDataCubit>().colorCode),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 2),
            ),
            height: size.height * 0.5,
            constraints: const BoxConstraints(maxWidth: 300),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ArabicOrEnglishWidget(
                      isArabic: context.read<WriteDataCubit>().isArabic,
                    ),
                    const SizedBox(height: 10),
                    ColorWidget(
                      currentColorCode: context
                          .read<WriteDataCubit>()
                          .colorCode,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (final text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'REQUIRED THIS FILED';
                        }
                        if (context
                            .read<WriteDataCubit>()
                            .iswordhaveDatabase()) {
                          return "this word is have alrady exits";
                        }
                        for (var i in text.split('')) {
                          if (context.read<WriteDataCubit>().isArabic) {
                            if (!RegExp(r'[\u0600-\u06FF]').hasMatch(i)) {
                              return 'arbaic only';
                            }
                          } else {
                            {
                              if (!RegExp(r'[A-Z]').hasMatch(i) &&
                                  !RegExp(r'[a-z]').hasMatch(i) &&
                                  i != " ") {
                                return 'english only';
                              }
                            }
                          }
                        }
                        return null;
                      },
                      controler: _controller,
                      labelText: "add Word",
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,

                      child: SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<WriteDataCubit>().addtext(
                              text: _controller.text,
                            );
                            if (_globalKey.currentState?.validate() ?? false) {
                              context.read<WriteDataCubit>().addWord();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Save",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
