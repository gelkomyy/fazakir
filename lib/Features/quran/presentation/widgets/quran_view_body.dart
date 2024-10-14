import 'package:fazakir/Features/quran/presentation/views/quran_page.dart';
import 'package:flutter/material.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, QuranPage.routeName);
        },
        child: const Text(
          "﷽ِ",
          style: TextStyle(fontSize: 23.55 * 1.5, fontFamily: 'Amiri'),
        ),
      ),
    );
  }
}
