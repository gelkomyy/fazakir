import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutReligionItem extends StatelessWidget {
  const AboutReligionItem(
      {super.key, this.width, required this.videoYoutubeEntity});
  final double? width;
  final VideoYoutubeEntity videoYoutubeEntity;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              SizedBox(
                width: width ?? MediaQuery.sizeOf(context).width * 0.45,
                child: AspectRatio(
                  aspectRatio: 1.77,
                  child: CachedNetworkImage(
                    imageUrl: videoYoutubeEntity.thumbnailurl,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.primaryColor),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Bounceable(
                            child: Card(
                              color: Colors.transparent,
                              shape: const CircleBorder(
                                  side: BorderSide(color: Colors.white)),
                              child: Padding(
                                padding: EdgeInsets.all(width == null ? 4 : 6),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: width == null ? 18 : 32,
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(width == null ? 5 : 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(8),
                  ),
                ),
                child: SvgPicture.asset(
                  Assets.assetsImagesHeartBlackIconSvg,
                  width: width == null ? 12 : 18,
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
            width: width ?? MediaQuery.sizeOf(context).width * 0.45,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    videoYoutubeEntity.title,
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
    );
  }
}
