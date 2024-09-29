import 'package:fazakir/core/cubits/filter_select_item_cubit/filter_select_item_cubit.dart';
import 'package:fazakir/core/widgets/custom_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSelectionItems extends StatelessWidget {
  const CustomSelectionItems({
    super.key,
    this.padding = const EdgeInsets.all(4),
    this.decoration,
    required this.texts,
    this.activeBorderRadius,
    this.activeColor = Colors.white,
    this.activeTextColor,
    this.textColor,
    this.backgroundColor = Colors.transparent,
    required this.filterKey,
  });
  final String filterKey;
  final List<String> texts;
  final EdgeInsets padding;
  final Decoration? decoration;
  final BorderRadiusGeometry? activeBorderRadius;
  final Color activeColor;
  final Color backgroundColor;

  final Color? textColor, activeTextColor;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSelectItemCubit, Map<String, String>>(
      builder: (context, state) {
        final selectItemCubit = context.read<FilterSelectItemCubit>();

        var selectedItem = selectItemCubit.state[filterKey];
        if (!texts.contains(selectedItem)) {
          selectItemCubit.setSelectedItem(texts[0], filterKey);
          selectedItem = selectItemCubit.state[filterKey];
        }

        return Container(
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
          child: Row(
            children: texts
                .map((text) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (selectedItem == text) {
                            return;
                          }
                          selectItemCubit.setSelectedItem(text, filterKey);
                        },
                        child: CustomSelectContainer(
                          textColor: textColor,
                          activeTextColor: activeTextColor,
                          activeColor: activeColor,
                          borderRadius: activeBorderRadius,
                          active: text == selectedItem,
                          text: text,
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
