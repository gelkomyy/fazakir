import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:fazakir/core/utils/notifications_service.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyDurationDialogContent extends StatefulWidget {
  const NotifyDurationDialogContent({
    super.key,
  });
  @override
  State<NotifyDurationDialogContent> createState() =>
      _NotifyDurationDialogContentState();
}

class _NotifyDurationDialogContentState
    extends State<NotifyDurationDialogContent> {
  bool isMinutes = true;

  int selectedValue = 5;

  @override
  void initState() {
    super.initState();
    isMinutes = getIt<SharedPreferences>().getBool('notify_is_minutes') ?? true;
    selectedValue =
        getIt<SharedPreferences>().getInt('notify_saved_duration') ?? 5;
  }

  Duration getSelectedDuration() {
    if (isMinutes) {
      return Duration(minutes: selectedValue);
    } else {
      return Duration(hours: selectedValue);
    }
  }

  Future<void> saveDurationToPrefs(Duration duration) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();

    await prefs.setInt('notify_saved_duration', selectedValue);
    await prefs.setBool('notify_is_minutes', isMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('اختيار الوحدة:'),
            const SizedBox(width: 8),
            DropdownButton<bool>(
              borderRadius: BorderRadius.circular(8),
              dropdownColor: AppColors.greyColor,
              elevation: 3,
              value: isMinutes,
              items: const [
                DropdownMenuItem(
                  value: true,
                  child: Text('دقائق'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('ساعات'),
                ),
              ],
              onChanged: (bool? value) {
                setState(() {
                  isMinutes = value!;
                  selectedValue = 5;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Scrollable List of Radio Buttons
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(60, (index) {
                int value = index + 1; // Values from 1 to 60
                String label = isMinutes
                    ? getArabicMinuteString(value)
                    : getArabicHourString(value);

                return RadioListTile<int>(
                  shape: const StadiumBorder(),
                  activeColor: AppColors.primaryColor,
                  overlayColor: WidgetStateProperty.all(
                      AppColors.primaryColor.withOpacity(0.2)),
                  title: Text(label),
                  value: value,
                  groupValue: selectedValue,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Confirm Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextButton(
                text: 'تأكيد',
                onPressed: () {
                  saveDurationToPrefs(getSelectedDuration()).then((_) {
                    if (context.mounted) {
                      NotificationService.updateNotificationDuration(
                          getSelectedDuration());
                      Navigator.pop(context);
                    }
                  }); // Save it in SharedPreferences
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextButton(
                backgroundColor: Colors.transparent,
                textColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                text: 'الغاء',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
