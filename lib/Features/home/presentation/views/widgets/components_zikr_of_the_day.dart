import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComponentsZikrOfTheDay extends StatefulWidget {
  const ComponentsZikrOfTheDay({super.key});

  @override
  State<ComponentsZikrOfTheDay> createState() => _ComponentsZikrOfTheDayState();
}

class _ComponentsZikrOfTheDayState extends State<ComponentsZikrOfTheDay>
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

          // Left icon (Heart)
          double x1 = 24 * t;
          double y1 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t);

          // Center icon (Copy)
          double x2 = -24 * t;
          double y2 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t);

          // Right icon (Share)
          double x3 = 0 * t;
          double y3 = -24 * (1 - t) - 0.5 * -24 * (1 - t) * (1 - t);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _handleTap();
                },
                child: SvgPicture.asset(
                  Assets.assetsImagesLayersShapeSvg,
                  width: 24,
                ),
              ),
              SizedBox(height: isShow ? 24 : 0),
              isShow
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(x1, y1),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SvgPicture.asset(
                              Assets.assetsImagesHeartBlackIconSvg,
                              width: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Transform.translate(
                          offset: Offset(x2, y2),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SvgPicture.asset(
                              Assets.assetsImagesCopyIconSvg,
                              width: 18,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              isShow
                  ? Transform.translate(
                      offset: Offset(x3, y3),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SvgPicture.asset(
                          Assets.assetsImagesShareIconSvg,
                          width: 16,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: isShow ? 12 : 0,
              ),
            ],
          );
        },
      ),
    );
  }
}
