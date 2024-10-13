import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/favorites/presentation/manager/cubits/cubit/favorites_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class ComponentsOfHadithItem extends StatefulWidget {
  const ComponentsOfHadithItem({super.key, required this.hadithEntity});

  final HadithEntity hadithEntity;

  @override
  State<ComponentsOfHadithItem> createState() => _ComponentsOfHadithItemState();
}

class _ComponentsOfHadithItemState extends State<ComponentsOfHadithItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _fadeAnimation;

  bool isShow = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _positionAnimation = Tween<double>(
      begin: 0.0, // Start position (0%)
      end: 1.0, // End position (100%)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully opaque
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (isShow) {
      // If icons are shown, reverse the animation first
      _controller.reverse().then((_) {
        // Once the reverse animation is complete, hide the icons
        setState(() {
          isShow = false;
        });
      });
    } else {
      // If icons are hidden, show them with a forward animation
      setState(() {
        isShow = true;
      });
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _positionAnimation,
        builder: (context, child) {
          double t = _positionAnimation.value;

          /*  // Left icon (Heart)
          double x1 = 24 * t;
          double y1 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t);

          // Center icon (Copy)
          double x2 = -24 * t;
          double y2 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t); */

          // Right icon (Share)
          double x3 = 0 * t;
          double y3 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Bounceable(
                onTap: () {
                  _handleTap();
                },
                child: SvgPicture.asset(
                  Assets.assetsImagesLayersShapeSvg,
                  width: 22,
                  height: 22,
                ),
              ),
              SizedBox(height: isShow ? 16 : 0),
              isShow
                  ? Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(
                            t * -0.23,
                            0.0,
                          ), // Use Alignment to position
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, state) {
                                final isFav = context
                                    .read<FavoritesCubit>()
                                    .favorites
                                    .any(
                                      (fav) =>
                                          fav.getIdentifier() ==
                                          widget.hadithEntity.getIdentifier(),
                                    );
                                return Bounceable(
                                  onTap: () => context
                                      .read<FavoritesCubit>()
                                      .toggleFavorite(widget.hadithEntity),
                                  child: SvgPicture.asset(
                                    Assets.assetsImagesHeartBlackIconSvg,
                                    width: 15,
                                    height: 15,
                                    colorFilter: ColorFilter.mode(
                                      isFav ? AppColors.redColor : Colors.black,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(
                            t * 0.23,
                            0.0,
                          ), // Use Alignment to position
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Bounceable(
                              scaleFactor: 0.5,
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text: widget.hadithEntity.hadith),
                                ).then(
                                  (_) {
                                    if (!context.mounted) return;
                                    showCustomSnackBar(context, 'تم نسخ النص');
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                Assets.assetsImagesCopyIconSvg,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: isShow ? 8 : 0,
              ),
              isShow
                  ? Transform.translate(
                      offset: Offset(x3, y3),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Bounceable(
                          scaleFactor: 0.5,
                          onTap: () {
                            Share.share(widget.hadithEntity.hadith);
                          },
                          child: SvgPicture.asset(
                            Assets.assetsImagesShareIconSvg,
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: isShow ? 8 : 0,
              ),
            ],
          );
        },
      ),
    );
  }
}
