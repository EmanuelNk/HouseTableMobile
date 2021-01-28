// relationship_seller: {
//         id: 1,
//        type:'represent',
//         text:'i represent the owner'
//     },
//     start_renovations: ASAP
//     estimate: $200,000
//     estimate_after_renovations: $250,000
//     debt: $100,000, 
//     streetNumber: 232
//     streetName: crown heights
//     municipalitySubdivision: brooklyn
//     municipality: new york
//     countrySubdivision: ny
//     postalCode: 4566
//     user_form_conditions: {
//         Kitchen: 1,
//         Bathroom: 2,
//         interior_paint: 3,
//         Roofing: 4,
//         Appliances: 5,
//         Floors: 1,
//     },
//     data_property: {
//         bedrooms: 3,
//         Bathrooms: 3,
//         square_footage: 123,
//         year_build: 1980,
//     },
import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/loanInfo.dart';
import 'package:housetable_mobile/Classes/statusInfo.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';
import 'package:housetable_mobile/screens/loanRequests.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:money2/money2.dart';

final usd = Currency.create('USD', 2);

Widget propText(String data, double size, Color textColor){
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    child: Text(data,
      style: TextStyle (
          color: textColor,
          fontSize: size
      ),
    ),
  );
}

Widget houseDetailsCard(BuildContext context, LoanInfo loanInfo) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4)
    ),
    color: ThemeColors.FOREGROUND_COLOR ,
      child: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Container(
            //       width: 50.0,
            //       height: 50.0,
            //       decoration:  BoxDecoration(
            //           shape: BoxShape.circle,
            //           image:  DecorationImage(
            //               fit: BoxFit.cover,
            //               image: AssetImage(Loan.profileImg)
            //           )
            //       )),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                propText(loanInfo.get_adress_line_1(), 25, Colors.white),
                propText(loanInfo.get_adress_line_2(), 20,Colors.amber[50]),
                propText('Start renovation: ' + loanInfo.startRenovation, 18,Colors.amber[50]),
                propText('Estimated Price: ' + Money.fromInt(loanInfo.estPrice, usd).toString(), 18,Colors.amber[50]),
                propText('RIO: ' + Money.fromInt(loanInfo.rio, usd).toString(), 18,Colors.amber[50]),
                propText('Debt: ' + Money.fromInt(loanInfo.debt,usd).toString(), 18,Colors.amber[50]),
                propText('Bedrooms: ' + loanInfo.dataProperty.bedrooms.toString(), 18,Colors.amber[50]),
                propText('Bathooms: ' + loanInfo.dataProperty.bathrooms.toString(), 18,Colors.amber[50]),
                propText('Square ft: ' + loanInfo.dataProperty.squareFootage.toString()+'sqft.', 18,Colors.amber[50]),
                propText('Year Built: ' + loanInfo.dataProperty.yearbuilt.toString(), 18,Colors.amber[50]),


              ],
            )
          ],
        ),
      ),
    ),
      )
  );
}