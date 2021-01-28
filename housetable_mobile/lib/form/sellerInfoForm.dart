import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:housetable_mobile/form/ratingsForm.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:housetable_mobile/Classes/jsonData.dart';
import 'package:camera/camera.dart';
// import 'package:http/http.dart' as http;

class SellerInfoForm extends StatefulWidget {
  final CameraDescription camera;
  final JsonData jsonData;
  const SellerInfoForm({Key key, this.jsonData, this.camera}) : super(key: key);
  @override
  _SellerInfoFormState createState() => _SellerInfoFormState();
}

class _SellerInfoFormState extends State<SellerInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String _picked1 = "i represent the owner";
  String _picked2 = "ASAP";

  Future<void> _nextPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('relationship', this._picked1);
    print(_picked1);
    print(_picked2);
    await prefs.setString('ready', this._picked2);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingsForm(camera: widget.camera,)),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text("New Request"),
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
                                  'What is your relationship \nto the seller of this home?',
                                  18,
                                  ThemeColors.ACCENT_COLOR),
                              RadioButtonGroup(
                                orientation: GroupedButtonsOrientation.VERTICAL,
                                margin: const EdgeInsets.only(left: 12.0),
                                onSelected: (String selected) => setState(() {
                                  _picked1 = selected;
                                }),
                                labels: <String>[
                                  for (Relationships i in widget.jsonData.relationships) i.text
                                  // widget.jsonData.relationships[0].text,
                                  // "I represent the owner",
                                  // "The seller is a prospective client",
                                  // "I do not represent the owner\n but I am referring to Housetable",
                                ],
                                picked: _picked1,
                                itemBuilder: (Radio rb, Text txt, int i) {
                                  return Row(
                                    children: <Widget>[
                                      Radio(
                                        key: rb.key,
                                        onChanged: rb.onChanged,
                                        groupValue: rb.groupValue,
                                        value: rb.value,
                                        activeColor: ThemeColors.ACCENT_COLOR,
                                      ),
                                      Expanded(
                                        child: Text(
                                          txt.data,
                                          style:
                                              TextStyle(color: Color(0xFFF3EBDE)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

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
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: ThemeColors.FOREGROUND_COLOR,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          propText(
                              'When will your client be ready\n to start renovations?',
                              18,
                              ThemeColors.ACCENT_COLOR),
                          RadioButtonGroup(
                            orientation: GroupedButtonsOrientation.VERTICAL,
                            margin: const EdgeInsets.only(left: 12.0),
                            onSelected: (String selected) => setState(() {
                              _picked2 = selected;
                            }),
                            labels: <String>[
                              for (StartRenovations i in widget.jsonData.startRenovations) i.text
                              // "ASAP",
                              // "2-4 weeks",
                              // "4-6 weeks",
                              // "Just browsing",
                            ],
                            picked: _picked2,
                            itemBuilder: (Radio rb, Text txt, int i) {
                              return Row(
                                children: <Widget>[
                                  Radio(
                                    key: rb.key,
                                    onChanged: rb.onChanged,
                                    groupValue: rb.groupValue,
                                    value: rb.value,
                                    activeColor: ThemeColors.ACCENT_COLOR,
                                  ),
                                  Text(
                                    txt.data,
                                    style: TextStyle(color: Color(0xFFF3EBDE)),
                                  ),
                                ],
                              );
                            },
                          ),

                          SizedBox(
                            height: 10.0,
                          ),
                          // RaisedButton()
                        ],
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
          //   MaterialPageRoute(builder: (context) => RatingsForm()),
          // );
        },
        elevation: 10,
      ),
    );
  }

  // List<Widget> _getRelationshipRadios() {
  //   List relationshipRadios = List<Widget>();
  //   int n = widget.jsonData.relationships.length;
  //   for (int i = 0; i < n; i++) {
  //     relationshipRadios.add(
  //       RadioListTile<String>(
  //         title: Text(widget.jsonData.relationships[i].text),
  //         value: widget.jsonData.relationships[i].type,
  //         groupValue: widget.jsonData.relationships[i].id.toString(),         
  //         onChanged: (_) {
  //           (String selected) => setState(() {
  //                 _picked1 = selected;});
  //         },
  //       ),
  //     );
  //   }
  //   return relationshipRadios;
  // }
}
