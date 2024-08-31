import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_item.dart';
import 'package:flutter/material.dart';

class AboutReligionViewBody extends StatelessWidget {
  const AboutReligionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.none,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: index + 1 == 10 ? 0 : 32,
              top: index == 0 ? 24 : 0,
            ),
            child: AboutReligionItem(
              width: MediaQuery.sizeOf(context).width * 0.9,
            ),
          ),
        );
      },
    );
  }
}
