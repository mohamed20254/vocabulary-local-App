import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_state.dart';
import 'package:vocabulary/core/constant/common/failure_widget.dart';
import 'package:vocabulary/core/constant/common/loading_widget.dart';
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
    log("=============================xxxxxxxxxx");
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: _buildFloatactionBuuton(context),

      appBar: AppBar(
        title: const Text("Words"),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (final context) => const CustomDialogFliter(),
            ),
            icon: const Icon(Icons.filter_list_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.words.length,
              itemBuilder: (final context, final index) {
                return Card(
                  color: Color(state.words[index].colorCode),
                  child: Center(
                    child: Text(
                      state.words[index].text,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
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
