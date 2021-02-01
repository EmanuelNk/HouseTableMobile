import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:housetable_mobile/Classes/loanInfo.dart';
import 'package:housetable_mobile/Classes/statusInfo.dart';
import 'package:housetable_mobile/Classes/houseInfo.dart';
import 'package:housetable_mobile/screens/loanDetails.dart';
import 'package:housetable_mobile/screens/loanRequests.dart';
import 'package:housetable_mobile/utils/theme.dart';
import 'package:housetable_mobile/Classes/captureImage.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
// import package:housetable_mobile/utils/theme.dart';

Widget houseCard(BuildContext context, HouseInfo houseInfo) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ThemeColors.FOREGROUND_COLOR,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                  color: ThemeColors.ACCENT_COLOR,
                  width: 10,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(houseInfo.profileImg)))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          houseInfo.address,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          houseInfo.date,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoanDetails(
                      loanInfo: houseInfo.loanInfo,
                    )),
          );
        },
      ));
}

Widget statusCard(BuildContext context, StatusInfo statusInfo) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ThemeColors.FOREGROUND_COLOR,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                  color: statusInfo.labelColor,
                  width: 10,
                )),
              ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            statusInfo.status,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          child: Text(
                            'Deals: ' + statusInfo.deals.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          child: Text(
                            'Value: ' + statusInfo.value.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoanRequests(
                      loanRequestList: statusInfo.housesInfo,
                    )),
          );
        },
      ));
}

Widget captureCard(BuildContext context, String roomName, CameraDescription camera) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: ThemeColors.FOREGROUND_COLOR,
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border(
          //       left: BorderSide(
          //     color: ThemeColors.ACCENT_COLOR,
          //     width: 7,
          //   )),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        roomName,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt_sharp,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TakePictureScreen(camera: camera, percents: 0.0,)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    // onTap: () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => LoanRequests(
    //               loanRequestList: statusInfo.housesInfo,
    //             )),
    //   );
    // },
  );
}
