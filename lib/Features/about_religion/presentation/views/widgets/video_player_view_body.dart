import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final videoId = convertYouTubeVideoUrlToId(widget.videoUrl);

    return AspectRatio(
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
              disableHorizontalScroll: false, // Allow horizontal scrolling
              allowsInlineMediaPlayback: true,
              javaScriptEnabled: true,
              supportZoom: true, // Enable zoom if needed
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
            },
            onLoadStart: (InAppWebViewController controller, WebUri? url) {
              setState(() {
                _isLoading = true;
                _progress = 0;
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
              });
              showCustomSnackBar(
                context,
                'Error: ${error.description}',
              );
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[200],
                color: AppColors.primaryColor,
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
