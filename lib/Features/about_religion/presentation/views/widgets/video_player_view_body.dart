import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoPlayerViewBody extends StatefulWidget {
  final String videoUrl;
  final double aspectRatio;

  const VideoPlayerViewBody(
      {super.key, required this.videoUrl, this.aspectRatio = 16 / 9});

  @override
  State<VideoPlayerViewBody> createState() => _VideoPlayerViewBodyState();
}

class _VideoPlayerViewBodyState extends State<VideoPlayerViewBody> {
  InAppWebViewController? webViewController;
  double _progress = 0;
  bool _isLoading = true;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    final videoId = convertYouTubeVideoUrlToId(widget.videoUrl);

    return errorMessage != null
        ? AspectRatio(
            aspectRatio: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.assetsImagesNoInternetShape,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: CustomTextButton(
                        text: 'اعادة التحميل',
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        backgroundColor: AppColors.textBlackColor,
                        textStyle: AppFontStyles.styleBold14(context).copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _progress = 0;
                            errorMessage = null;
                            webViewController?.reload();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri.uri(
                      Uri.parse(
                          "https://www.youtube.com/embed/$videoId?controls=1&autoplay=1&rel=0&showinfo=0"),
                    ),
                  ),
                  initialSettings: InAppWebViewSettings(
                    mediaPlaybackRequiresUserGesture: false,
                    disableVerticalScroll: false, // Allow vertical scrolling
                    disableHorizontalScroll:
                        false, // Allow horizontal scrolling
                    allowsInlineMediaPlayback: true,
                    javaScriptEnabled: true,
                    supportZoom: true, // Enable zoom if needed
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                  },
                  onLoadStart:
                      (InAppWebViewController controller, WebUri? url) {
                    setState(() {
                      _isLoading = true;
                      _progress = 0;
                      errorMessage = null;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, WebUri? url) {
                    setState(() {
                      _isLoading = false;
                      _progress = 1.0;
                    });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  onEnterFullscreen: (InAppWebViewController controller) {
                    _enterFullScreen();
                  },
                  onExitFullscreen: (InAppWebViewController controller) {
                    _exitFullScreen();
                  },
                  onReceivedError: (InAppWebViewController controller,
                      WebResourceRequest request, WebResourceError error) {
                    setState(() {
                      _isLoading = false;
                      errorMessage = error.description;
                    });
                    showCustomSnackBar(
                      context,
                      'Error: ${error.description}',
                    );
                  },
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator.adaptive(
                      value: _progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor),
                    ),
                  ),
              ],
            ),
          );
  }

  void _enterFullScreen() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  void _exitFullScreen() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  static String? convertYouTubeVideoUrlToId(String url,
      {bool trimWhitespaces = true}) {
    if (trimWhitespaces) url = url.trim();

    if (!url.startsWith('http') && url.length == 11) return url;

    final regexList = [
      RegExp(
          r'^https?:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11})'),
      RegExp(
          r'^https?:\/\/(?:music\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11})'),
      RegExp(
          r'^https?:\/\/(?:www\.|m\.)?youtube\.com\/shorts\/([_\-a-zA-Z0-9]{11})'),
      RegExp(
          r'^https?:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11})'),
      RegExp(r'^https?:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11})'),
    ];

    for (var regex in regexList) {
      final match = regex.firstMatch(url);
      if (match != null) {
        return match.group(1);
      }
    }

    return null;
  }
}
