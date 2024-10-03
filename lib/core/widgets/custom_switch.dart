import 'package:flutter/material.dart';
import 'package:fazakir/core/utils/app_colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, this.onChanged});
  final void Function(bool)? onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isEnable = false;

  void _toggleSwitch() {
    setState(() {
      isEnable = !isEnable;
      widget.onChanged?.call(isEnable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut, // Smooth ease animation
        width: 48,
        height: 14, // Adjusted for better thumb centering
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isEnable
              ? AppColors.primaryColor
              : AppColors.greyColor, // Track color
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            // Thumb (Circle)
            AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut, // Smooth transition curve
              end: !isEnable ? 0 : 48 - 22,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 22, // Thumb size
                height: 22, // Thumb size
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Thumb color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2), // Adds a subtle shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
