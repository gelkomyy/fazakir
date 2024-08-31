import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/about_religion/presentation/views/widgets/video_player_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/image_with_play_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutReligionItem extends StatefulWidget {
  const AboutReligionItem(
      {super.key, this.width, required this.videoYoutubeEntity});
  final double? width;
  final VideoYoutubeEntity videoYoutubeEntity;

  @override
  State<AboutReligionItem> createState() => _AboutReligionItemState();
}

class _AboutReligionItemState extends State<AboutReligionItem> {
  bool isPlayed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            SizedBox(
              width: widget.width ?? MediaQuery.sizeOf(context).width * 0.45,
              child: isPlayed
                  ? VideoPlayerViewBody(
                      aspectRatio: 1.77,
                      videoUrl: widget.videoYoutubeEntity.url,
                    )
                  : AspectRatio(
                      aspectRatio: 1.77,
                      child: ImageWithPlayArrow(
                        onTapPlayArrow: () {
                          setState(() {
                            isPlayed = true;
                          });
                        },
                        smallerWidth: widget.width == null,
                        imageUrl: widget.videoYoutubeEntity.thumbnailurl,
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.all(widget.width == null ? 5 : 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(8),
                ),
              ),
              child: SvgPicture.asset(
                Assets.assetsImagesHeartBlackIconSvg,
                width: widget.width == null ? 12 : 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.redColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: widget.width ?? MediaQuery.sizeOf(context).width * 0.45,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.videoYoutubeEntity.title,
                  style: widget.width == null
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
                  width: widget.width == null ? 13 : 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
