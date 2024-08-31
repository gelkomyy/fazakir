import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ImageWithPlayArrow extends StatelessWidget {
  const ImageWithPlayArrow({
    super.key,
    required this.imageUrl,
    this.smallerWidth = false,
    required this.onTapPlayArrow,
  });
  final String imageUrl;
  final void Function() onTapPlayArrow;
  final bool smallerWidth;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
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
              onTap: onTapPlayArrow,
              child: Card(
                color: Colors.transparent,
                shape:
                    const CircleBorder(side: BorderSide(color: Colors.white)),
                child: Padding(
                  padding: EdgeInsets.all(smallerWidth ? 4 : 6),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: smallerWidth ? 18 : 32,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
