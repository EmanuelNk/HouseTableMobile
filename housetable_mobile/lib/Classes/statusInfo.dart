import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';

class StatusInfo {
  String status;
  Color labelColor;
  // Icon statusIcon;
  List<HouseInfo> housesInfo;
  int value;
  int deals;

  StatusInfo({this.status,this.housesInfo,this.labelColor,value,this.deals});
}