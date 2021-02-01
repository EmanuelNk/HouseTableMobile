import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'dart:math';

import 'package:money2/money2.dart';

class OutputForm extends StatelessWidget {
  Random random = new Random();
  final usd = Currency.create('USD', 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ThemeColors.BACKGROUND_COLOR),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/HouseTableLogo.png',
              height: 200,
              width: 200,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 17,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: ThemeColors.FOREGROUND_COLOR,
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          propText('Here is how much we can lend your client:',
                              20, Colors.white),
                          propText(
                              (Money.fromInt(
                                          (random.nextInt(40000) + 20000), usd)
                                      .format('S###,###')
                                      .toString() +
                                  "\$"),
                              35,
                              ThemeColors.ACCENT_BRIGHTER),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    'Our underwriting team will review \nthe information, and get back to you \nwithin 24-48 hours.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.normal , fontFamily: GoogleFonts.exo().fontFamily),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Text(
                    'Thank you for using Housetable!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amber[100], fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.normal , fontFamily: GoogleFonts.exo().fontFamily),
                  ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
