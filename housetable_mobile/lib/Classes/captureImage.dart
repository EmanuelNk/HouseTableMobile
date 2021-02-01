import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housetable_mobile/screens/capture.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final double percents;

  const TakePictureScreen({Key key, @required this.camera, this.percents})
      : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  CameraController _controller;
  Icon captureIcon = Icon(Icons.camera);
  Future<void> _initializeControllerFuture;
  bool _showLoad = false;

  @override
  void initState() {
    super.initState();
    if (widget.percents == 1) {
      setState(() {
        captureIcon = Icon(Icons.arrow_forward_ios);
      });
    }
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: Stack(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 9.0,
                percent: widget.percents,
                center: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ClipOval(
                    child: Material(
                      color: ThemeColors.ACCENT_COLOR, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: captureIcon,
                        ),
                        onTap: () async {
                          setState(() {
                            _showLoad = true;
                                                    });
                          // Take the Picture in a try / catch block. If anything goes wrong,
                          // catch the error.
                          try {
                            // Ensure that the camera is initialized.
                            await _initializeControllerFuture;

                            // Construct the path where the image should be saved using the
                            // pattern package.
                            Directory tempDir = await getTemporaryDirectory();
                            String tempPath = tempDir.path;
                            final path = tempPath;
                            // join(
                            //   // Store the picture in the temp directory.
                            //   // Find the temp directory using the `path_provider` plugin.
                            //   (await getTemporaryDirectory()).path,
                            //   '${DateTime.now()}.png',
                            // );

                            // Attempt to take a picture and log where it's been saved.
                            await _controller.takePicture();

                            // If the picture was taken, display it on a new screen.
                            if (widget.percents < 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(
                                    camera: widget.camera,
                                    percents: widget.percents + 0.2,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CapturePage(
                                            camera: widget.camera,
                                          )));
                            }
                          } catch (e) {
                            // If an error occurs, log the error to the console.
                            print(e);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                progressColor: Color(0xFF1C7AB1),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: LinearProgressBar(
            //     color: Color(0xFF479429),
            //     percent: widget.percents,
            //   ),
            // )
          ],
        ),
        Center(
            child: Opacity(
              opacity: _showLoad ? 0.7 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: SpinKitChasingDots(
          color: Colors.white,
          size: 150,

        ),
                ))),
      ]),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera),
      //   // Provide an onPressed callback.
      //   onPressed: () async {
      //     // Take the Picture in a try / catch block. If anything goes wrong,
      //     // catch the error.
      //     try {
      //       // Ensure that the camera is initialized.
      //       await _initializeControllerFuture;

      //       // Construct the path where the image should be saved using the
      //       // pattern package.
      //       Directory tempDir = await getTemporaryDirectory();
      //       String tempPath = tempDir.path;
      //       final path = tempPath;
      //       // join(
      //       //   // Store the picture in the temp directory.
      //       //   // Find the temp directory using the `path_provider` plugin.
      //       //   (await getTemporaryDirectory()).path,
      //       //   '${DateTime.now()}.png',
      //       // );

      //       // Attempt to take a picture and log where it's been saved.
      //       await _controller.takePicture();

      //       // If the picture was taken, display it on a new screen.
      //       if (widget.percents < 0.9) {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => TakePictureScreen(
      //               camera: widget.camera,
      //               percents: widget.percents + 0.1,
      //             ),
      //           ),
      //         );
      //       } else {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => CapturePage(
      //                       camera: widget.camera,
      //                     )));
      //       }
      //     } catch (e) {
      //       // If an error occurs, log the error to the console.
      //       print(e);
      //     }
      //   },
      // ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

Widget flashScreen() {
  return Stack(
    children: [
      Container(color: Colors.white),
      Scaffold(
          // The rest of your page
          ),
    ],
  );
}
