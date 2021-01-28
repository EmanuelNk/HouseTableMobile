import 'package:flutter/material.dart';
import 'package:housetable_mobile/form/pricingForm.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

class RatingsForm extends StatefulWidget {
  final CameraDescription camera;

  const RatingsForm({Key key, this.camera}) : super(key: key);
  @override
  _RatingsFormState createState() => _RatingsFormState();
}

class _RatingsFormState extends State<RatingsForm> {
  final _formKey = GlobalKey<FormState>();
  List<double> _ratings = [3, 3, 3, 3, 3, 3];

  Future<void> _nextPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('kitchenRate', this._ratings[0]);
    await prefs.setDouble('bathroomRate', this._ratings[1]);
    await prefs.setDouble('interiorRate', this._ratings[2]);
    await prefs.setDouble('appliancesRate', this._ratings[3]);
    await prefs.setDouble('floorRate', this._ratings[4]);
    await prefs.setDouble('roofingRate', this._ratings[5]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PricingForm(camera: widget.camera,)),
    );
  }

  Widget objectRating(String title, int id) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          propText(title + ': ', 18, Colors.amber[50]),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            glow: false,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: ThemeColors.ACCENT_COLOR,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                this._ratings[id] = rating;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text("Rating Form"),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: ThemeColors.FOREGROUND_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              propText(
                                  "How would you rate\nthe house's condition?",
                                  25,
                                  Colors.amber[50]),
                              objectRating('Kitchen', 0),
                              objectRating('Bathrooms', 1),
                              objectRating('Interior Paint', 2),
                              objectRating('Appliances', 3),
                              objectRating('Floor', 4),
                              objectRating('Roofing', 5),
                              SizedBox(
                                height: 10.0,
                              ),
                              // RaisedButton()
                            ],
                          ),
                        ),
                      ),
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
          //   MaterialPageRoute(builder: (context) => PricingForm()),
          // );
          // print("kitchen: ${this._ratings[0]}, bathroom: ${this._ratings[1]}, floor: ${this._ratings[4]}");
        },
        elevation: 10,
      ),
    );
  }
}
