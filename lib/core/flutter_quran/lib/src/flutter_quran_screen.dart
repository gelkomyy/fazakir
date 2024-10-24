import 'dart:async';

import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/flutter_quran/lib/src/flutter_quran_screen_bloc_builder_body.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/ayah.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/bookmark.dart';
import 'package:fazakir/core/flutter_quran/lib/src/utils/flutter_quran_utils.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran/quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'app_bloc.dart';
import 'models/quran_page.dart';
part 'utils/images.dart';
part 'utils/toast_utils.dart';
part 'widgets/bsmallah_widget.dart';
part 'widgets/quran_line.dart';
part 'widgets/default_drawer.dart';
part 'widgets/ayah_long_click_dialog.dart';

class FlutterQuranScreen extends StatefulWidget {
  const FlutterQuranScreen({
    super.key,
    this.onPageChanged,
    required this.pageNumber,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final int pageNumber;

  ///[onPageChanged] if provided it will be called when a quran page changed
  final Function(int)? onPageChanged;

  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  State<FlutterQuranScreen> createState() => _FlutterQuranScreenState();
}

class _FlutterQuranScreenState extends State<FlutterQuranScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WakelockPlus.enable();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => AppBloc.quranCubit.animateToPage(widget.pageNumber - 1));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffFFF9F1),
          resizeToAvoidBottomInset: false,
          body: FlutterQuranScreenBlocBuilderBody(
            onPageChanged: widget.onPageChanged,
            shouldHighlightText: widget.shouldHighlightText,
            highlightVerse: widget.highlightVerse,
          ),
        ),
      ),
    );
  }
}
