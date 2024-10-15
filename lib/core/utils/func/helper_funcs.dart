import 'package:dartarabic/dartarabic.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:share_plus/share_plus.dart';
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

void shareApp(BuildContext context) {
  const String appLink =
      'https://play.google.com/store/apps/details?id=com.fazakir.elkomy';
  const String shareText =
      'اكتشف تطبيق إسلامي شامل يقدّم مجموعة واسعة من الميزات الدينية والروحانية. سهل الاستخدام بتصميم جذاب يناسب جميع الأعمار والمستويات الدينية. جربه الآن!';
  const String shareSubject = 'تطبيق إسلامي شامل لجميع المسلمين';
  final RenderBox? box = context.findRenderObject() as RenderBox?;
  Share.share(
    '$shareText $appLink',
    subject: shareSubject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}

String removeTashkeels(String input) {
  return DartArabic.stripTatweel(
    DartArabic.stripHarakat(
      removeDiacritics2(
        normalizeArabicText(
          normalise(
            removeDiacritics(
              input.toString().toLowerCase(),
            ),
          ),
        ),
      ),
    ),
  ).toString().toLowerCase();
}
