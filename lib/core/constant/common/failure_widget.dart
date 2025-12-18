import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailureScreen extends StatelessWidget {
  final String text;
  final void Function()? ontap;

  const FailureScreen({super.key, required this.text, this.ontap});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(
              "Oops!",
              style: GoogleFonts.aBeeZee(
                fontSize: 29,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if (text.contains('internet connection'))
              const Icon(Icons.wifi_off_sharp),
            const SizedBox(height: 20),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 6, 83, 216),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              onPressed: ontap,
              child: Text(
                "try again",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
