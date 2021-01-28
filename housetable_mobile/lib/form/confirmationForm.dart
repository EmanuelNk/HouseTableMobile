import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:money2/money2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:housetable_mobile/screens/capture.dart';
import 'package:camera/camera.dart';
import 'dart:convert';

class ConfirmationForm extends StatefulWidget {
  final CameraDescription camera;

  const ConfirmationForm({Key key, this.camera}) : super(key: key);
  @override
  _ConfirmationFormState createState() => _ConfirmationFormState();
}

class _ConfirmationFormState extends State<ConfirmationForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController bathroomController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController sqftController = TextEditingController();
  TextEditingController yearbuiltController = TextEditingController();
  TextEditingController estimateController = TextEditingController();
  TextEditingController currentController = TextEditingController();
  TextEditingController renovatedController = TextEditingController();

  int _bathrooms = 5;
  int _bedrooms = 4;
  int _sgft = 1027;
  int _year = 1917;

  Future<void> _nextPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CapturePage(camera: widget.camera,)),
    );
  }

  void postJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address');
    String city = prefs.getString('city');
    String state = prefs.getString('state');
    String zipCode = prefs.getString('zip code');
    int estPrice = prefs.getInt('estPrice');
    int renovatePrice = prefs.getInt('renovatePrice');
    int debt = prefs.getInt('debtPrice');
    int bathrooms = prefs.getInt('bathrooms');
    int bedrooms = prefs.getInt('bedrooms');
    int sqft = prefs.getInt('sqft');
    int year = prefs.getInt('year');
    double kitchenRate = prefs.getDouble('kitchenRate');
    double bathroomRate = prefs.getDouble('bathroomRate');
    double interiorRate = prefs.getDouble('interiorRate');
    double appliancesRate = prefs.getDouble('appliancesRate');
    double floorRate = prefs.getDouble('floorRate');
    double roofingRate = prefs.getDouble('roofingRate');
    String relationship = prefs.getString('relationship');
    String readyToRenovate = prefs.getString('ready');

    // print(appliancesRate);

    var jsonData = json.encode({
      "transaction": {
        "relationship_seller": {
          "type": "represent",
          "text": relationship
        },
        "start_renovations": readyToRenovate,
        "estimate": estPrice,
        "estimate_after_renovations": renovatePrice,
        "debt": debt,
        "agancy": "everhome",
        "realtor": "michael green"
      },
      "property": {
        "streetNumber": 111,
        "streetName": address,
        "municipalitySubdivision": "no",
        "municipality": city,
        "countrySubdivision": state,
        "postalCode": zipCode,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "square_foot": sqft,
        "year_build": year,
        "general_conditions": {
          "kitchen": kitchenRate,
          "bathroom": bathroomRate,
          "interior_paint": interiorRate,
          "roofing": roofingRate,
          "appliances": appliancesRate,
          "floors": floorRate
        }
      }
    });
    

    // var data = json.encode({
    //   'address': "Flutter",
    //   'city': ['flutter', 'snippets'],
    //   'state': '0.0.20',
    //   'zip code': 13511,
    //   'estPrice': 123,
    //   'renovatePrice': 83257,
    //   'debtPrice': 953,
    //   'bathrooms': 235,
    //   'bedrooms': 4,
    //   'sqft': 3,
    //   'year': 4,
    //   'kitchenRate': 345,
    //   'bathroomRate': 345,
    //   'interiorRate': 3,
    //   'appliancesRate': 4,
    //   'floorRate': 43,
    //   'roofingRate': 234,
    //   'relationship': 234,
    //   'ready': 234,
    // });
    // print(jsonData);
    sendJsonData(jsonData);
    _nextPage();
  }

  Future<http.Response> sendJsonData(String json) {
  // print("walla");
  return http.post(
    'https://housetabledemo.azure-api.net/api/transactions',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json
  );
}

  Future<void> saveInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bathrooms', this._bathrooms);
    await prefs.setInt('bedrooms', this._bedrooms);
    await prefs.setInt('sqft', this._sgft);
    await prefs.setInt('year', this._year);
  }

  @override
  void initState() {
    saveInfo();
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
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: ThemeColors.FOREGROUND_COLOR,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    propText(
                                        'Please confirm the following information about the home:',
                                        24,
                                        Colors.white),
                                    propText(
                                        'We receive our information from publicly available sources like tax records.',
                                        15,
                                        Colors.amber[50])
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: ThemeColors.FOREGROUND_COLOR,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    CounterCard(
                                      currentController: bedroomController,
                                      title: 'Bedrooms',
                                      initvalue: 5,
                                    ),
                                    CounterCard(
                                      currentController: bathroomController,
                                      title: 'Bathrooms',
                                      initvalue: 4,
                                    ),
                                    CounterCard(
                                      currentController: sqftController,
                                      title: 'Sqft.',
                                      initvalue: 1027,
                                    ),
                                    CounterCard(
                                      currentController: yearbuiltController,
                                      title: 'Year Built',
                                      initvalue: 1917,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlineButton(
                            onPressed: () {postJson();},
                            color: ThemeColors.ACCENT_COLOR,
                            borderSide: BorderSide(
                                color: ThemeColors.ACCENT_BRIGHTER, width: 1),
                            highlightedBorderColor: ThemeColors.ACCENT_COLOR,
                            child: propText('Submit Request', 20,
                                ThemeColors.ACCENT_BRIGHTER),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class CounterCard extends StatelessWidget {
  const CounterCard(
      {Key key, @required this.currentController, this.title, this.initvalue})
      : super(key: key);

  final TextEditingController currentController;
  final String title;
  final int initvalue;

  Future<void> saveValue(String title, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        elevation: 8,
        color: ThemeColors.PRIMATY_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              propText(title, 25, Colors.white),
              SizedBox(
                width: 150,
                child: Container(
                  // borderRadius: BorderRadius.circular(10.0),
                  // color: ThemeColors.PRIMATY_2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      width: 3.0,
                      color: Color((0xFF292828)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 0),
                    child: TextField(
                      cursorColor: ThemeColors.ACCENT_BRIGHTER,
                      textAlign: TextAlign.center,
                      controller: currentController
                        ..text = initvalue.toString(),
                      style: TextStyle(
                          color: ThemeColors.ACCENT_BRIGHTER, fontSize: 30),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        saveValue(title, value);
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
