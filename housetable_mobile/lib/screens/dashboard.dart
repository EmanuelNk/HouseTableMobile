import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';
import 'package:housetable_mobile/Classes/jsonData.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/cards.dart';
import 'package:housetable_mobile/Classes/statusInfo.dart';
import 'package:housetable_mobile/Classes/loanInfo.dart';


// class StatusInfo {
//   String status;
//   Color labelColor;
//   // Icon statusIcon;
//   List<HouseInfo> housesInfo;
//   int value;
//   int deals;

//   StatusInfo({this.status,this.housesInfo,this.labelColor,value,this.deals});
// }

class Dashboard extends StatefulWidget {
  // final JsonData json;

  const Dashboard({ Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

   static LoanInfo loan_info = LoanInfo(startRenovation: 'ASAP', countrySubdivision: 'NY', 
  dataProperty: DataProperty(bathrooms: 3,bedrooms: 2, squareFootage: 1027, yearbuilt: 1917),
  debt: 100000, estPrice: 200000, municipality: 'New York', municipalitySubdivision: 'Brooklyn', postalCode: 19370,rio: 250000, streetName: 'Crown Heights',streetNumber: 13,
  userFormConditions: UserFormConditions(appliances: 5, bathroom: 3,floors: 2,interiorPaint: 4,kitchen: 2,roofing: 1));

  static List<HouseInfo> loanRequestList = [
      HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "12.05.98", value: 12000, deals: 4, loanInfo: loan_info),
      HouseInfo(status: 'rejected', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "13.04.1233", value: 102000, deals: 3, loanInfo: loan_info),
      HouseInfo(status: 'completed', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "13.13.1013", value: 123144, deals: 2, loanInfo: loan_info),
      HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "13.13.1013", value: 123144, deals: 2, loanInfo: loan_info),
      HouseInfo(status: 'completed', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "13.13.1013", value: 123144, deals: 2, loanInfo: loan_info),
      HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: loan_info.get_adress_line_1(), date: "13.13.1013", value: 123144, deals: 2, loanInfo: loan_info)
  ];
 
  List<StatusInfo> statusesInfo = [
    StatusInfo(status: 'pending Housetable approval', labelColor: Color(0xFF5F83A7), housesInfo: loanRequestList, deals: 25, value: 1000200),
    StatusInfo(status: 'pending seller approval', labelColor: Color(0xFF6EB4A3), housesInfo: loanRequestList, deals: 25, value: 1000200),
    StatusInfo(status: 'completed', labelColor: Color(0xFF70BB74), housesInfo: loanRequestList, deals: 25, value: 1000200),
    StatusInfo(status: 'rejected by Housetable', labelColor: Color(0xFF9C4646), housesInfo: loanRequestList, deals: 25, value: 1000200),
    StatusInfo(status: 'rejected by seller', labelColor: Color(0xFF995433), housesInfo: loanRequestList, deals: 25, value: 1000200),
  ];
    int _selectedIndex = 0;
    String _currentStatus = 'pending';
    List<String> statusList = ['completed', 'pending', 'rejected'];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR ,
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
                  children: statusesInfo.map((p) {
                    return statusCard(context,p);
                  }).toList()
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}