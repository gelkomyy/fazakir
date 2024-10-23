part of '../flutter_quran_screen.dart';

class BasmallahWidget extends StatelessWidget {
  const BasmallahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: (screenSize.width * .2),
            right: (screenSize.width * .2),
            top: 8,
            bottom: 2),
        child: Image.asset(
          Assets.assetsImagesBasmala,
          color: Colors.black,
          width: MediaQuery.of(context).size.width * .4,
        ),
      ),
    );
  }
}
