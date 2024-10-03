import 'package:fazakir/Features/settings/presentation/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SettingsViewBody(),
    );
  }
}
