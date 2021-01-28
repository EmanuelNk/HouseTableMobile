import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:housetable_mobile/widgets/houseDetailsCard.dart';
import 'package:housetable_mobile/Classes/loanInfo.dart';



class LoanDetails extends StatefulWidget {
  final LoanInfo loanInfo;   
  const LoanDetails({ Key key, this.loanInfo}) : super(key: key);
  @override
  _LoanDetailsState createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {

  
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
              Column(
                children: <Widget>[
                  houseDetailsCard(context, widget.loanInfo)
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}