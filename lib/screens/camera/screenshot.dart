import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
class ScreenshotPage extends StatefulWidget {
  ScreenshotPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScreenshotPageState createState() => _ScreenshotPageState();
}

class _ScreenshotPageState extends State<ScreenshotPage> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ScreenshotPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 5.0),
                    color: Colors.amberAccent,
                  ),
                  child: Text("This widget will be captured as an image")),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  ShowCapturedWidget(context, capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Capture An Invisible Widget',
              ),
              onPressed: () {
                var container = Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 5.0),
                      color: Colors.redAccent,
                    ),
                    child: Text(
                      "This is an invisible widget",
                      style: Theme.of(context).textTheme.headline6,
                    ));
                screenshotController
                    .captureFromWidget(
                    InheritedTheme.captureAll(
                        context, Material(child: container)),
                    delay: Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

// _saved(File image) async {
//   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
//   print("File Saved to Gallery");
// }
}