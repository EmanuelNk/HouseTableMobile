import 'package:flutter/material.dart';
import 'package:housetable_mobile/form/confirmationForm.dart';
import 'package:housetable_mobile/form/pricingForm3.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money2/money2.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'pricingForm.dart';

class PricingForm2 extends StatefulWidget {
  final CameraDescription camera;

  const PricingForm2({Key key, this.camera}) : super(key: key);
  @override
  _PricingForm2State createState() => _PricingForm2State();
}

class _PricingForm2State extends State<PricingForm2> {
  final _formKey = GlobalKey<FormState>();
  final usd = Currency.create('USD', 0);
  TextEditingController estimateController = TextEditingController();
  TextEditingController debtController = TextEditingController();
  TextEditingController renovatedController = TextEditingController();
  int _renovatedPrice = 0;
  bool _renValidate = false;

  Widget priceCard(String title, TextEditingController currentController,
      int price, bool valid) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: ThemeColors.FOREGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              propText(title, 25, Colors.amber[50]),
              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 3,
              ),
              TextField(
                controller: currentController,
                decoration: InputDecoration(
                    labelText: "Enter your number",
                    errorText: valid ? null : "you must enter a number"),
                style: TextStyle(color: Colors.white, fontSize: 20),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _setAndValidPrice(currentController, valid);
                },
                onSubmitted: (value) {
                  _setAndValidPrice(currentController, valid);
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(Money.fromInt(price, usd).format('S###,###'),
                    style: TextStyle(
                        fontSize: 50, color: ThemeColors.ACCENT_COLOR)),
              ),
              SizedBox(
                height: 10.0,
              ),
              // RaisedButton()
            ],
          ),
        ),
      ),
    );
  }

  void _setAndValidPrice(TextEditingController currentController, bool valid) {
    setState(() {
      if (currentController == renovatedController) {
        _renovatedPrice = int.parse(renovatedController.text);
        _renovatedPrice == 0 ? _renValidate = false : _renValidate = true;
      } else if (renovatedController.text.isEmpty) _renovatedPrice = 0;
    });
  }

  Future<void> _nextPage() async {
    if (_renValidate) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('renovatePrice', this._renovatedPrice);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PricingForm3(camera: widget.camera)),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text("Price After Renovation"),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: priceCard(
                              "What would you estimate the house's price to be after renovation?",
                              renovatedController,
                              this._renovatedPrice,
                              this._renValidate),
                        ),
                      ],
                    ),
                  ),
                  logoIcon(200,300)
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        disabledElevation: 0,
        onPressed: () {
          _nextPage();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ConfirmationForm()),
          // );
          // print("kitchen: ${this._ratings[0]}, bathroom: ${this._ratings[1]}, floor: ${this._ratings[4]}");
        },
        elevation: 10,
      ),
    );
  }
}
