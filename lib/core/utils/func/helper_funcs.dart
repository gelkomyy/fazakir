import 'package:url_launcher/url_launcher.dart';

String getArabicHourString(int hours) {
  if (hours == 1) return 'ساعة';
  if (hours == 2) return 'ساعتين';
  if (hours >= 3 && hours <= 10) return '$hours ساعات';
  return '$hours ساعة';
}

String getArabicMinuteString(int minutes) {
  if (minutes == 1) return 'دقيقة';
  if (minutes == 2) return 'دقيقتين';
  if (minutes >= 3 && minutes <= 10) return '$minutes دقائق';
  return '$minutes دقيقة';
}

Future<void> openLink(String url) async {
  final Uri googleMapsUrl = Uri.parse(url);

  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl);
  }
}
