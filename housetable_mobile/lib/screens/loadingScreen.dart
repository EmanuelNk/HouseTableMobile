import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housetable_mobile/screens/outputScreen.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _currentOpacity = 0.7;
  bool _animState = true;
  Timer _timer;
  int _start = 5;

  void opacityAnimation() {
    setState(() {
      _animState ? _currentOpacity = 0.7 : _currentOpacity = 0.3;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OutputForm()),
            );
          });
        } else {
          setState(() {
            opacityAnimation();
            _animState = !_animState;
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeColors.BACKGROUND_COLOR,
        child: Stack(children: <Widget>[
          Center(
            heightFactor: 10,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _currentOpacity,
              child: Text(
                "Analizing Data",
                style: TextStyle(
                    color: Colors.amber[50],
                    fontSize: 35,
                    decoration: TextDecoration.none,
                    fontFamily: GoogleFonts.exo().fontFamily,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Opacity(
                opacity: 0.8,
                child: SpinKitFadingCube(
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  logoIcon(200, 200),
                ],
              ),
            ],
          )
        ]));
  }
}
