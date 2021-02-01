import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:housetable_mobile/widgets/BaseWidgets.dart';
import 'Classes/houseInfo.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/screens/loanRequests.dart';
import 'package:housetable_mobile/screens/dashboard.dart';
import 'package:housetable_mobile/widgets/cards.dart';
import 'widgets/DropDownButton.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

import 'Form/addressForm.dart';
// import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'screens/mainScreen.dart';
import 'Classes/jsonData.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    theme: themeUtil.getTheme(),
    home: MyHome(camera: firstCamera,),
  ));
}

class MyHome extends StatefulWidget {
  final CameraDescription camera;

  const MyHome({Key key, this.camera}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

// Future <JsonData> _fetchData() async{
//   return fetchJson();
// }

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    getJson().then((data) {
      setState(() {
        this._jsonData = data;
      });
    });
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // _MyHomeState(){
  //   _fetchData().then((val)=>setState(() {
  //         json = val;
  //       }));
  // }
  JsonData _jsonData;

  Future getJson() async {
    JsonData jsonData = await fetchJson();
    return jsonData;
    // setState(() {
    //       _jsonData = jsonData;
    //       print(_jsonData.relationships[0].text);
    //     });
  }

  List<HouseInfo> loanRequest = [
    HouseInfo(
        status: 'pending',
        profileImg: 'assets/house.png',
        address: "Jerusalem Har-Nof 007.",
        date: "12.05.98",
        value: 12000,
        deals: 4),
    HouseInfo(
        status: 'rejected',
        profileImg: 'assets/house.png',
        address: "Beverly hills 1256.",
        date: "13.04.1233",
        value: 102000,
        deals: 3),
    HouseInfo(
        status: 'completed',
        profileImg: 'assets/house.png',
        address: "New York 2nd Ave.",
        date: "13.13.1013",
        value: 123144,
        deals: 2),
    HouseInfo(
        status: 'pending',
        profileImg: 'assets/house.png',
        address: "Brooklyn 99.",
        date: "13.13.1013",
        value: 123144,
        deals: 2),
    HouseInfo(
        status: 'completed',
        profileImg: 'assets/house.png',
        address: "Tel Aviv the 3rd.",
        date: "13.13.1013",
        value: 123144,
        deals: 2),
    HouseInfo(
        status: 'completed',
        profileImg: 'assets/house.png',
        address: "Tel Aviv the 3rd.",
        date: "13.13.1013",
        value: 123144,
        deals: 2),
    HouseInfo(
        status: 'pending',
        profileImg: 'assets/house.png',
        address: "Rosh Pina 17.",
        date: "13.13.1013",
        value: 123144,
        deals: 2)
  ];

  int _selectedIndex = 0;
  String _currentStatus = 'pending';
  List<String> statusList = ['completed', 'pending', 'rejected'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddressForm(
                    json: this._jsonData,
                    camera: widget.camera,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return LoanRequest(loanRequestList: loanRequest,);
    // getJson();
    // return Scaffold(body: Center(child: propText('Loading', 30, ThemeColors.ACCENT_COLOR)),);

    if (_jsonData == null) {
      getJson();
      return Scaffold(
        body: Center(
          child: Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/HouseTableLogo.png')))),
        ),
      );
    } else {
      return Scaffold(
        body: Scaffold(
          body: MainScreen(),
          // body: AddressForm(),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('home')),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.search), title: Text('search')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box), title: Text('add')),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.person), title: Text('profile')),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Color(0xFF966C49),
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped),
      );
    }
  }
}
