import 'package:fazakir/Features/home/presentation/views/widgets/home_view_body_header.dart';

import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeViewBodyHeader(),
      ],
    );
  }
}
