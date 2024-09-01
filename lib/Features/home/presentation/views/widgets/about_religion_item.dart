import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/about_religion/presentation/views/video_player_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/video_player_image_stack.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutReligionItem extends StatelessWidget {
  const AboutReligionItem(
      {super.key,
      this.width,
      this.pushToVideoPlayerView = false,
      required this.videoYoutubeEntity});
  final double? width;
  final VideoYoutubeEntity videoYoutubeEntity;
  final bool pushToVideoPlayerView;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: pushToVideoPlayerView
          ? () {
              Navigator.pushNamed(
                context,
                VideoPlayerView.routeName,
                arguments: {
                  'videoUrl': videoYoutubeEntity.url,
                },
              );
            }
          : null,
      child: SizedBox(
        width: width ?? MediaQuery.sizeOf(context).width * 0.425,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayerImageStack(
              pushToVideoPlayerView: pushToVideoPlayerView,
              smallerWidth: width == null,
              videoYoutubeEntity: videoYoutubeEntity,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: width != null
                  ? null
                  : getResponsiveFontSize(context, fontSize: 35),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      videoYoutubeEntity.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: width == null
                          ? AppFontStyles.styleBold10(context)
                          : AppFontStyles.styleBold13(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 6,
                    ),
                    child: SvgPicture.asset(
                      Assets.assetsImagesScreenDisplayShapeSvg,
                      width: width == null ? 13 : 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
