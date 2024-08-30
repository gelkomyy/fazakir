import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class AboutReligionView extends StatelessWidget {
  const AboutReligionView({super.key});

  static const String routeName = 'aboutReligionView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_religion),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
