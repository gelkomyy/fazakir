import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar_models.dart';
import 'package:fazakir/core/utils/app_colors.dart';
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
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                alignment: Alignment.center,
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
                              style:
                                  AppFontStyles.styleBold10(context).copyWith(
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
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final Color selectedItemActiveColor = navBarEssentials
        .items[navBarEssentials.selectedIndex].activeColorPrimary;
    final double itemWidth = (MediaQuery.of(context).size.width -
            ((navBarEssentials.padding.left + navBarEssentials.padding.right) +
                (navBarEssentials.margin.left +
                    navBarEssentials.margin.right))) /
        navBarEssentials.items.length;
    return Padding(
      padding: navBarEssentials.margin,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: navBarEssentials.navBarHeight,
            padding: navBarEssentials.padding,
            decoration: BoxDecoration(
                color: navBarEssentials.backgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: AppColors.greyColor,
                  width: 0.5,
                )),
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
          Transform.translate(
            offset: const Offset(
              0,
              -1,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: navBarEssentials.padding.horizontal,
              ),
              child: Row(
                children: <Widget>[
                  AnimatedContainer(
                    duration: navBarEssentials.itemAnimationProperties.duration,
                    curve: navBarEssentials.itemAnimationProperties.curve,
                    color: Colors.transparent,
                    width: (itemWidth * navBarEssentials.selectedIndex) +
                        (32 * 0.4),
                    height: 2,
                  ),
                  Flexible(
                    child: AnimatedContainer(
                      duration:
                          navBarEssentials.itemAnimationProperties.duration,
                      curve: navBarEssentials.itemAnimationProperties.curve,
                      width: 32,
                      height: 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedItemActiveColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
