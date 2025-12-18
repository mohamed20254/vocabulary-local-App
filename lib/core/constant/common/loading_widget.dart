import 'package:flutter/material.dart';

class LodingScreen extends StatelessWidget {
  const LodingScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
