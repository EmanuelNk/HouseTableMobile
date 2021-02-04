import 'package:flutter/material.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'package:housetable_mobile/Classes/jsonData.dart';
import 'sellerInfoForm.dart';
import 'dart:math';
import 'package:camera/camera.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    
    await Future.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {'name': query + index.toString(), 'price': Random().nextInt(100)};
    });
  }
}

class AddressesService {
  static final List<String> addresses = [
    '7162 Young Court, Webster, NY, 14580',
    '528 West Catherine Rd., Rome, NY, 13440',
    '4 Jefferson Dr., Bronx, NY, 10462',
    '836 Windsor Ave., Brooklyn, NY, 11212',
    '784 West Summerhouse St., Brooklyn, NY, 11201',
    '25 East Street, Jamaica, NY, 11434',
    '878 Shub Farm St., Brooklyn, NY, 11208',
    '17 Old Atlantic Street, New York, NY, 10128',
    '7273 Trout Avenue, Brooklyn, NY, 11214',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(addresses);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class AddressForm extends StatefulWidget {
  final CameraDescription camera;
  final JsonData json;
  const AddressForm({Key key, this.json, this.camera})  : super(key: key);
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final List<String> addressesList = [
    'New York times square',
    'New york 5th ave.',
    'New York 7th Ave.'
  ];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedAddress;
  String _address = ' ';
  String _city = ' ';
  String _state = ' ';
  String _zipcode = ' ';

  Map<String, String> getAdressDetails(String address) {
    List<String> splittedAddress = address.split(', ');
    return {
      'address': splittedAddress[0],
      'city': splittedAddress[1],
      'state': splittedAddress[2],
      'zip code': splittedAddress[3]
    };
  }

  void saveAdressInfo(String address) {
    setState(() {
      this._selectedAddress = address;
      this._address = getAdressDetails(address)['address'];
      this._city = getAdressDetails(address)['city'];
      this._state = getAdressDetails(address)['state'];
      this._zipcode = getAdressDetails(address)['zip code'];
    });
  }

  Future<void> _nextPage() async {
    if (this._formKey.currentState.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address', this._address);
      await prefs.setString('city', this._city);
      await prefs.setString('state', this._state);
      await prefs.setString('zipcode', this._zipcode);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SellerInfoForm(jsonData: widget.json, camera: widget.camera,)),
      );
    } else {
      return () {
        // do anything else you may want to here
        return null;
        ;
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text("Addresst"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: ThemeColors.FOREGROUND_COLOR,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            propText('What is the address?', 18, Colors.white),
                            TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  style: TextStyle(color: Colors.white),
                                  controller: this._typeAheadController,
                                  decoration:
                                      InputDecoration(labelText: 'Address')),
                              suggestionsCallback: (pattern) {
                                return AddressesService.getSuggestions(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                    title: Text(
                                  suggestion,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ));
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (suggestion) {
                                this._typeAheadController.text = suggestion;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please select an address';
                                }
                              },
                              onSaved: (value) => saveAdressInfo(value),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                              color: ThemeColors.ACCENT_COLOR,
                              child: Text('Submit'),
                              onPressed: () {
                                if (this._formKey.currentState.validate()) {
                                  this._formKey.currentState.save();
                                  // Scaffold.of(context).showSnackBar(SnackBar(
                                  //     content: Text(
                                  //         'Address: ${getAdressDetails(this._selectedAddress)['address']}\t City: ${getAdressDetails(this._selectedAddress)['city']}')));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: ThemeColors.FOREGROUND_COLOR,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          titledPropText('Address', this._address, 18,
                              ThemeColors.ACCENT_COLOR, Colors.white),
                          titledPropText('City', this._city, 18,
                              ThemeColors.ACCENT_COLOR, Colors.white),
                          titledPropText('State', this._state, 18,
                              ThemeColors.ACCENT_COLOR, Colors.white),
                          titledPropText('Zip Code', this._zipcode, 18,
                              ThemeColors.ACCENT_COLOR, Colors.white)
                        ],
                      ),
                    ),
                  ),
                  logoIcon(200,300)
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        disabledElevation: 0,
        onPressed: () {
          _nextPage();
        },
        elevation: 10,
      ),
    );
  }
}
