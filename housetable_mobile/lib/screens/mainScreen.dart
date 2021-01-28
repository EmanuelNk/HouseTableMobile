import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';
import 'package:housetable_mobile/screens/dashboard.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/cards.dart';
import 'package:housetable_mobile/Classes/statusInfo.dart';
import 'package:housetable_mobile/Classes/jsonData.dart';


// class StatusInfo {
//   String status;
//   Color labelColor;
//   // Icon statusIcon;
//   List<HouseInfo> housesInfo;
//   int value;
//   int deals;

//   StatusInfo({this.status,this.housesInfo,this.labelColor,value,this.deals});
// }

class MainScreen extends StatefulWidget {

  // final JsonData json;
  const MainScreen({ Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {




  @override
  Widget build(BuildContext context) {
    return Dashboard();
  }
}