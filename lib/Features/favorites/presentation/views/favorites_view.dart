import 'package:fazakir/Features/favorites/presentation/views/widgets/favorites_view_body.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المفضلة',
          style: AppFontStyles.styleBold20(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: FavoritesViewBody(),
      ),
    );
  }
}
