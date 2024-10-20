import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    closeIconColor: Colors.red.shade900,
    // margin: const EdgeInsetsDirectional.symmetric(horizontal: 50, vertical: 20),
    /* shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
      topStart: Radius.circular(16),
      topEnd: Radius.circular(16),
    )), */
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    content: Text(
      text,
      //textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!,
    ),
  ));
}
