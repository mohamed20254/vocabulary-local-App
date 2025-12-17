import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_state.dart';
import 'package:vocabulary/core/constant/common/custom_text_form_field.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (final context) => const Center(child: DialogWidget()),
          );
        },
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(title: const Text("sss")),
      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
          if (state is ReadDataCubitSuccessState) {
            return Center(
              child: Text(
                state.words.length.toString(),
                style: TextStyle(fontSize: 30),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
