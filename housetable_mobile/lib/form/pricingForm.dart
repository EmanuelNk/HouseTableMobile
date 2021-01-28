import 'package:flutter/material.dart';
import 'package:housetable_mobile/form/confirmationForm.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money2/money2.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';


class PricingForm extends StatefulWidget {
  final CameraDescription camera;

  const PricingForm({Key key, this.camera}) : super(key: key);
  @override
  _PricingFormState createState() => _PricingFormState();
}

class _PricingFormState extends State<PricingForm> {
  final _formKey = GlobalKey<FormState>();
  final usd = Currency.create('USD', 0);
  TextEditingController estimateController = TextEditingController();
  TextEditingController debtController = TextEditingController();
  TextEditingController renovatedController = TextEditingController();
  int _estimatedPrice = 0;
  bool _estValidate = false;
  int _debtPrice = 0;
  bool _debtValidate = false;
  int _renovatedPrice = 0;
  bool _renValidate = false;

  void _setAndValidPrice(TextEditingController currentController, bool valid) {
    setState(() {
      if (currentController == estimateController) {
        _estimatedPrice = int.parse(estimateController.text);
        _estimatedPrice == 0 ? _estValidate = false : _estValidate = true;
      }
      if (currentController == renovatedController) {
        _renovatedPrice = int.parse(renovatedController.text);
        _renovatedPrice == 0 ? _renValidate = false : _renValidate = true;
      }
      if (currentController == debtController) {
        _debtPrice = int.parse(debtController.text);
        _debtPrice == 0 ? _debtValidate = false : _debtValidate = true;
      } else if (estimateController.text.isEmpty) _estimatedPrice = 0;
    });
  }


  Future<void> _nextPage() async {
    if (_debtValidate && _estValidate && _renValidate) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('estPrice', this._estimatedPrice);
      await prefs.setInt('renovatePrice', this._renovatedPrice);
      await prefs.setInt('debtPrice', this._debtPrice);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfirmationForm(camera: widget.camera,)),
      );
    } else {
      return null;
    }
  }

  Widget priceCard(String title, TextEditingController currentController,
      int price, bool valid) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: ThemeColors.FOREGROUND_COLOR,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            propText(title, 18, Colors.white),
            TextField(
              controller: currentController,
              decoration: InputDecoration(
                  labelText: "Enter your number",
                  errorText:
                      valid ? null : "you must enter a number higher than 0"),
              style: TextStyle(color: Colors.amber[50]),
              keyboardType: TextInputType.number,
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
                  style: TextStyle(fontSize: 28, color: Colors.white)),
            ),
            SizedBox(
              height: 10.0,
            ),
            // RaisedButton()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text("Pricing Form"),
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
                              "What would you estimate the house's 'as is' price to be?",
                              estimateController,
                              this._estimatedPrice,
                              this._estValidate),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: priceCard(
                              "What would you estimate the house's price to be after renovation?",
                              renovatedController,
                              this._renovatedPrice,
                              this._renValidate),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: priceCard(
                              "How much debt does the home have?",
                              debtController,
                              this._debtPrice,
                              this._debtValidate),
                        )
                      ],
                    ),
                  ),
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
