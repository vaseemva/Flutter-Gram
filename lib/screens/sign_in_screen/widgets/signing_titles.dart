import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigningTitles extends StatelessWidget {
  const SigningTitles({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ],
    );
  }
}
