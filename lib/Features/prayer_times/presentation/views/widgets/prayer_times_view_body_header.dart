import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrayerTimesViewBodyHeader extends StatelessWidget {
  const PrayerTimesViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesMuslimWomen),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.transparent, Colors.black],
          ),
        ),
        child: Column(
          children: [
            Text(
              'لمعرفة أقرب مسجد',
              style: AppFontStyles.styleBold15(context).copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                final Uri googleMapsUrl = Uri.parse(
                    'https://www.google.com/maps/search/?api=1&query=mosques+near+me');

                if (await canLaunchUrl(googleMapsUrl)) {
                  await launchUrl(googleMapsUrl);
                } else {}
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.pin_drop,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'لمعرفة القبلة',
              style: AppFontStyles.styleBold15(context).copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.explore,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
