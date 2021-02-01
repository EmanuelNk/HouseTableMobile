import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housetable_mobile/screens/outputScreen.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

// class StatusInfo {
//   String status;
//   Color labelColor;
//   // Icon statusIcon;
//   List<HouseInfo> housesInfo;
//   int value;
//   int deals;

//   StatusInfo({this.status,this.housesInfo,this.labelColor,value,this.deals});
// }

class CapturePage extends StatefulWidget {
  // final JsonData json;
  final CameraDescription camera;
  const CapturePage({Key key, this.camera}) : super(key: key);

  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  List<String> rooms = ['Kitchen', 'Bathroom', 'Room 1', 'Room 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.menu, size: 35, color: Colors.white),
                  Icon(Icons.add, size: 35, color: Colors.white)
                ],
              ),
              SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: rooms.map((p) {
                      return captureCard(context, p, widget.camera);
                    }).toList()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: OutlineButton(
                  color: Colors.blue,
                  child: Text('finish'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OutputForm(
                                
                              )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
