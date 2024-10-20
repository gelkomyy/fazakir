import 'package:fazakir/Features/about_religion/presentation/views/widgets/video_player_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({super.key, required this.videoUrl});
  static const String routeName = 'videoPlayerView';
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مشاهدة الفيديو',
          style: AppFontStyles.styleBold20(context),
        ),
        leading: Bounceable(
          child: const Card(
            color: AppColors.textBlackColor,
            shape: CircleBorder(),
            margin: EdgeInsetsDirectional.only(start: 24),
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: VideoPlayerViewBody(
          videoUrl: videoUrl,
        ),
      ),
    );
  }
}
