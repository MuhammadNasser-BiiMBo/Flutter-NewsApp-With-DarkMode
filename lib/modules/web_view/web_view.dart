import 'package:flutter/material.dart';
import "package:webview_universal/webview_universal.dart";
class WebViewScreen extends StatefulWidget {
  final String url;
  WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState(url);
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String url;
  _WebViewScreenState(this.url);
  // InAppWebViewController? webViewController;

  WebViewController webViewController= WebViewController();
  @override
  void initState() {
    super.initState();
    task();
  }
  Future<void> task() async{
     webViewController.init( setState: setState, uri: Uri.parse(url), context: context,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  webViewController.init(context: context, setState: setState, uri: Uri.parse(url));
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body:  WebView(
        controller: webViewController,
        )
    );
  }
}
