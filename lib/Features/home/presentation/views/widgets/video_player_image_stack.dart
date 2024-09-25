import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/about_religion/presentation/views/video_player_view.dart';
import 'package:fazakir/Features/about_religion/presentation/views/widgets/video_player_view_body.dart';
import 'package:fazakir/Features/favorites/presentation/manager/cubits/cubit/favorites_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/widgets/image_with_play_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class VideoPlayerImageStack extends StatefulWidget {
  const VideoPlayerImageStack({
    super.key,
    required this.videoYoutubeEntity,
    this.smallerWidth = false,
    this.pushToVideoPlayerView = false,
  });
  final VideoYoutubeEntity videoYoutubeEntity;
  final bool smallerWidth;
  final bool pushToVideoPlayerView;
  @override
  State<VideoPlayerImageStack> createState() => _VideoPlayerImageStackState();
}

class _VideoPlayerImageStackState extends State<VideoPlayerImageStack> {
  bool isPlayed = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        isPlayed
            ? AspectRatio(
                aspectRatio: 1.77,
                child: VideoPlayerViewBody(
                  aspectRatio: 1.77,
                  videoUrl: widget.videoYoutubeEntity.url,
                ),
              )
            : AspectRatio(
                aspectRatio: 1.77,
                child: ImageWithPlayArrow(
                  onTapPlayArrow: () {
                    if (widget.pushToVideoPlayerView) {
                      Navigator.pushNamed(
                        context,
                        VideoPlayerView.routeName,
                        arguments: {
                          'videoUrl': widget.videoYoutubeEntity.url,
                        },
                      );
                    } else {
                      setState(() {
                        isPlayed = true;
                      });
                    }
                  },
                  smallerWidth: widget.smallerWidth,
                  imageUrl: widget.videoYoutubeEntity.thumbnailurl,
                ),
              ),
        Container(
          padding: EdgeInsets.all(widget.smallerWidth ? 5 : 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(8),
            ),
          ),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFav = context.read<FavoritesCubit>().favorites.any(
                    (fav) =>
                        fav.getIdentifier() ==
                        widget.videoYoutubeEntity.getIdentifier(),
                  );
              return Bounceable(
                onTap: () => context
                    .read<FavoritesCubit>()
                    .toggleFavorite(widget.videoYoutubeEntity),
                child: SvgPicture.asset(
                  Assets.assetsImagesHeartBlackIconSvg,
                  width: widget.smallerWidth ? 12 : 18,
                  colorFilter: ColorFilter.mode(
                    isFav ? AppColors.redColor : AppColors.greyColor,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
