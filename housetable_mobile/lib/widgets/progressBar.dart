import 'dart:collection';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {

  final double percent;
  final Color color;

  const LinearProgressBar({Key key, this.percent, this.color})
      : super(key: key);
  @override
  _LinearProgressBarState createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new LinearPercentIndicator(
          width: MediaQuery.of(context).size.width-30,
          animation: true,
          lineHeight: 20.0,
          animateFromLastPercent: false,
          animationDuration: 1000,
          percent: widget.percent,
          center: Text(
            (widget.percent*100).toStringAsFixed(1) + '%',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: widget.color,
        ));
  }
}
