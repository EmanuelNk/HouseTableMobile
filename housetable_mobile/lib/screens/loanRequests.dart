import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/cards.dart';


class LoanRequests extends StatefulWidget {
  final List<HouseInfo> loanRequestList;   
  const LoanRequests({ Key key, this.loanRequestList}) : super(key: key);
  @override
  _LoanRequestsState createState() => _LoanRequestsState();
}

class _LoanRequestsState extends State<LoanRequests> {


  // List<HouseInfo> loanRequestList = [
  //     HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: "Jerusalem Har-Nof 007.", date: "12.05.98", value: 12000, deals: 4),
  //     HouseInfo(status: 'rejected', profileImg: 'assets/house.png',address: "Beverly hills 1256.", date: "13.04.1233", value: 102000, deals: 3),
  //     HouseInfo(status: 'completed', profileImg: 'assets/house.png',address: "New York 2nd Ave.", date: "13.13.1013", value: 123144, deals: 2),
  //     HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: "Brooklyn 99.", date: "13.13.1013", value: 123144, deals: 2),
  //     HouseInfo(status: 'completed', profileImg: 'assets/house.png',address: "Tel Aviv the 3rd.", date: "13.13.1013", value: 123144, deals: 2),
  //     HouseInfo(status: 'pending', profileImg: 'assets/house.png',address: "Rosh Pina 17.", date: "13.13.1013", value: 123144, deals: 2)
  // ];
    
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
                  DropdownButtonHideUnderline(            
                    child: DropdownButton<String>(
                    elevation: 24,
                    icon: Icon(Icons.keyboard_arrow_down),
                    value: _currentStatus, 
                    items: <String>['complete', 'pending', 'rejected'].map((String value) {
                      return  DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style:TextStyle (
                             color: Colors.white,
                             fontSize: 25,
                             fontFamily: 'Raleway'
                         ) ,),
                        );
                     
                    }).toList(),
                    onChanged: (_) {},
                      ),
                  ),
                  Icon(Icons.add, size: 35, color: Colors.white)
                ],
              ),
              Column(
                children: widget.loanRequestList.map((p){
                  return houseCard(context, p);
                }).toList()
              )
            ],
          ),
        ),
      ),
    );
  }
}