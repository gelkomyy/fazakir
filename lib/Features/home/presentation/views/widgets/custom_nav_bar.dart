import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar_models.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    required this.navBarEssentials,
    super.key,
  });
  final NavBarEssentials navBarEssentials;

  Widget _buildItem(BuildContext context, final PersistentBottomNavBarItem item,
          final bool isSelected) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              duration: navBarEssentials.itemAnimationProperties.duration,
              curve: navBarEssentials.itemAnimationProperties.curve,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    item.svgAsset != null
                        ? SvgWithColorAnimation(
                            item: item,
                            isSelected: isSelected,
                          )
                        : IconTheme(
                            data: IconThemeData(
                                size: item.iconSize,
                                color: isSelected
                                    ? (item.activeColorSecondary ??
                                        item.activeColorPrimary)
                                    : item.inactiveColorPrimary ??
                                        item.activeColorPrimary),
                            child: isSelected
                                ? item.icon
                                : item.inactiveIcon ?? item.icon,
                          ),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.title!,
                            style: AppFontStyles.styleBold10(context).copyWith(
                              color: isSelected
                                  ? (item.activeColorSecondary ??
                                      item.activeColorPrimary)
                                  : item.inactiveColorPrimary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final Color selectedItemActiveColor = navBarEssentials
        .items[navBarEssentials.selectedIndex].activeColorPrimary;
    final double iconSize =
        navBarEssentials.items[navBarEssentials.selectedIndex].iconSize;
    final int selectedIndex = navBarEssentials.selectedIndex;

    return Padding(
      padding: navBarEssentials.margin,
      child: Stack(
        children: [
          Container(
            height: navBarEssentials.navBarHeight,
            padding: navBarEssentials.padding,
            decoration: BoxDecoration(
              color: navBarEssentials.backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
              children: navBarEssentials.items.map((final item) {
                final int index = navBarEssentials.items.indexOf(item);
                return Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (index != navBarEssentials.selectedIndex) {
                        navBarEssentials.items[index].iconAnimationController
                            ?.forward();
                        navBarEssentials.items[navBarEssentials.selectedIndex]
                            .iconAnimationController
                            ?.reverse();
                      }
                      if (navBarEssentials.items[index].onPressed != null) {
                        navBarEssentials.items[index].onPressed!(
                            navBarEssentials.selectedScreenBuildContext);
                      } else {
                        navBarEssentials.onItemSelected?.call(index);
                      }
                    },
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: _buildItem(
                        context,
                        item,
                        navBarEssentials.selectedIndex == index,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // The moving indicator bar
          // The moving indicator bar

          Transform.translate(
            offset: const Offset(0, -0.5),
            child: Padding(
              padding: EdgeInsets.only(
                left: navBarEssentials.padding.left,
                right: navBarEssentials.padding.right,
              ),
              child: AnimatedAlign(
                alignment: _getAlignmentForIndex(selectedIndex),
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                child: Container(
                  width: iconSize,
                  height: 2.5,
                  color: selectedItemActiveColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AlignmentDirectional _getAlignmentForIndex(int index) {
    switch (index) {
      case 0:
        return AlignmentDirectional.topStart;
      case 1:
        return const AlignmentDirectional(
            -0.51, 1.0); // Adjust the value based on your layout
      case 2:
        return const AlignmentDirectional(-0.015, 1.0);
      case 3:
        return const AlignmentDirectional(
            0.475, 1.0); // Adjust the value based on your layout
      case 4:
        return const AlignmentDirectional(
          0.95,
          1.0,
        );
      default:
        return AlignmentDirectional.center;
    }
  }
}

class SvgWithColorAnimation extends StatefulWidget {
  const SvgWithColorAnimation({
    super.key,
    required this.isSelected,
    required this.item,
    this.duration = const Duration(milliseconds: 300),
  });
  final bool isSelected;
  final PersistentBottomNavBarItem item;
  final Duration duration;
  @override
  State<SvgWithColorAnimation> createState() => _SvgWithColorAnimationState();
}

class _SvgWithColorAnimationState extends State<SvgWithColorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _updateColorAnimation();

    // Start the animation initially if needed
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant SvgWithColorAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      // Update the color animation when the selection state changes
      _updateColorAnimation();
      _controller.forward(from: 0.0);
    }
  }

  void _updateColorAnimation() {
    _colorAnimation = ColorTween(
      begin: widget.isSelected
          ? widget.item.inactiveColorPrimary ??
              widget.item.inactiveColorSecondary
          : widget.item.activeColorSecondary ?? widget.item.activeColorPrimary,
      end: widget.isSelected
          ? widget.item.activeColorSecondary ?? widget.item.activeColorPrimary
          : widget.item.inactiveColorPrimary ??
              widget.item.inactiveColorSecondary,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return SvgPicture.asset(
          widget.item.svgAsset!,
          width: widget.item.iconSize,
          colorFilter: ColorFilter.mode(
            _colorAnimation.value!,
            BlendMode.srcIn,
          ),
        );
      },
    );
  }
}
