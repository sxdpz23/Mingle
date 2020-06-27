import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:citoto/utilities/data.dart';
import 'package:citoto/widgets/chats.dart';
import 'package:citoto/screens/conversations.dart';

///
/// Hello this is just an index of all the things to let you help navigate.
///
/// Use the below keywords to FIND the function or classes -
///

class Mingle extends StatefulWidget {
  final String page;
  final String type;
  final String citID;

  Mingle({this.page, this.type, this.citID});

  @override
  MingleState createState() => MingleState();
}

class MingleState extends State<Mingle> with TickerProviderStateMixin {
  Duration _duration = Duration(milliseconds: 500);

  /// same duration for everyone
  var _socialProfessional;

  var _height;
  var _width;
  final String _switcherName = ' Mingle';
  IconData _switcherIcon;
  Color _color;
  Color _altColor;
  Color _txtColor;
  Color _backColor;
  Color _shadowColor;
  Color _borderColor;
  bool helper = true;
  final Radius _radius = Radius.circular(15.0);

  @override
  void initState() {
    super.initState();
    print("Mingle kaa Karmaa bissi");
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false)
        .init(widget.citID);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    if (helper == true) {
      switch (widget.type) {
        case 'social':
          setState(() {
            _socialProfessional = true;
            helper = false;
          });
          break;
        case 'professional':
          setState(() {
            _socialProfessional = false;
            helper = false;
          });
      }
    }
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: _outsideMingle()));
  }

  /// To get the name of the person that is tapped from the chats list.

  Widget _outsideMingle() {
    if (_socialProfessional == true) {
      setState(() {
        _switcherIcon = Feather.refresh_ccw;
        _backColor = Colors.white;
        _txtColor = Colors.black;
        _color = Colors.white;
        _shadowColor = Colors.black.withOpacity(0.5);
        _borderColor = Colors.grey;
        _altColor = _txtColor;
        //_altColor = _txtColor.withAlpha(0x88);
      });
    } else {
      setState(() {
        _switcherIcon = Feather.refresh_cw;
        _color = Color.fromARGB(0xCC, 51, 62, 80);
        _txtColor = Colors.white;
        _backColor = Colors.black;
        _shadowColor = Colors.black.withOpacity(0.4);
        _borderColor = _color;
        //_altColor = _txtColor;
        _altColor = _txtColor;
      });
    }

    return Scaffold(
      backgroundColor: _backColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Container(
              height: _height,
              width: _width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: (_height * 1 / 6 * 0.45)),
                  _searchTitleBar(),
                  SizedBox(
                    height: (_height * 1 / 6 * 0.15),
                  ),
                  Center(
                    child: _viewMingle(),
                  ),
                ],
              ),
            ),
            _bottomRightAddBackButton(),
          ],
        ),
      ),
    );
  }

  _bottomRightAddBackButton() {
    return Positioned(
      bottom: 5.0,
      right: 20.0,
      child: AnimatedContainer(
        duration: _duration,
        width: _width / 6,
        height: _width / 6,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _color,
            border: Border.all(color: _borderColor, width: 1.0),
            boxShadow: [
              BoxShadow(color: _shadowColor, spreadRadius: 1.0, blurRadius: 3.0)
            ]),
        child: Center(
          child: IconButton(
            icon: Icon(Icons.add),
            color: _txtColor,
            iconSize: _width * 0.9 * 0.1,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  TextEditingController _searchController = TextEditingController();

  Widget _searchTitleBar() {
    double height = 40.0;
    double width = _width * 0.975;

    return Container(
      alignment: Alignment.topCenter,
      width: _width,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AnimatedContainer(
          margin: EdgeInsets.only(
            left: _width * 0.025 * 0.5,
            right: _width * 0.025 * 0.5,
          ),
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: _color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
            border: Border.all(color: _shadowColor, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: _shadowColor.withOpacity(0.4),
                blurRadius: 3.0,
                offset: Offset(4, 3),
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    textAlign: TextAlign.left,
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _switcherName.toUpperCase(),
                      hintStyle: TextStyle(
                          color: _altColor,
                          letterSpacing: 5.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times-New-Roman',
                          fontSize: width * 0.1 * 0.5),
                      fillColor: Colors.blue,
                      suffixIcon: Icon(
                        Icons.search,
                        color: _txtColor,
                      ),
                    ),
                    style: TextStyle(
                        color: _txtColor,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  icon: Icon(_switcherIcon),
                  color: _txtColor,
                  onPressed: () {
                    setState(() {
                      _socialProfessional = !_socialProfessional;
                    });
                  },
                ),
              ],
            ),
          ),
          duration: _duration,
        ),
      ),
    );
  }

  List<String> allRoutes = [
    'Near Me',
    'Kiosk',
    'Primary',
    'Secondary',
    'Trash / Spam'
  ];
  int navigateCount = 1;

  DragStartDetails startVerticalDragDetails;

  /// for storing swipe value
  DragUpdateDetails updateVerticalDragDetails;

  /// for storing swipe value

  Widget _viewMingle() {
    var height = _height - (_height * 1 / 6 * 0.7) - 50.0;
    var width = _width * 0.975;
    return GestureDetector(
//      onTapUp: (TapUpDetails details) => () {
//        var x = details.globalPosition.dx;
//        var y = details.globalPosition.dy;
//        print("tap up " + x.toString() + ", " + y.toString());
//      },
//      onTapDown: (TapDownDetails details) => () {
//        var x = details.globalPosition.dx;
//        var y = details.globalPosition.dy;
//        print("tap down " + x.toString() + ", " + y.toString());
//      },
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
        print("\nStart - $dragDetails");
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
        print("\nUpdated - $dragDetails");
      },
      onVerticalDragEnd: (endDetails) {
        double dx = updateVerticalDragDetails.localPosition.dx -
            startVerticalDragDetails.localPosition.dx;
        double dy = updateVerticalDragDetails.localPosition.dy -
            startVerticalDragDetails.localPosition.dy;
        double velocity = endDetails.primaryVelocity;

        //Convert values to be positive
        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;

        if (velocity < 0) {
          /// Checking on Swipe Up
          setState(() {
            if (navigateCount != (allRoutes.length - 1)) {
              navigateCount++;
            } else {
              navigateCount = navigateCount;
            }
          });
          print('\n$navigateCount');
        } else {
          /// Checking on Swipe Down
          setState(() {
            if (navigateCount != 0) {
              navigateCount--;
            } else {
              navigateCount = navigateCount;
            }
          });
          print('\n$navigateCount');
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height,
          width: _width,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              AnimatedContainer(
                  height: (navigateCount == 0 ? _boxHeight('', height) : 0.0),
                  duration: (navigateCount == 0)
                      ? _duration
                      : Duration(microseconds: 0)),
              _nearMe(height, width),
              SizedBox(
                  height: (navigateCount < 2 ? height * 1 / 5 * 0.2 : 0.0)),
              _kiosk(height, width),
              SizedBox(
                  height: ((0 < navigateCount && navigateCount < 3)
                      ? height * 1 / 5 * 0.2
                      : 0.0)),
              _primary(height, width),
              SizedBox(
                  height: ((1 < navigateCount && navigateCount < 4)
                      ? height * 1 / 5 * 0.2
                      : 0.0)),
              _secondary(height, width),
              SizedBox(
                  height: (navigateCount > 2 ? height * 1 / 5 * 0.2 : 0.0)),
              _trashSpam(height, width),
              AnimatedContainer(
                height: (navigateCount == 4 ? _boxHeight('', height) : 0.0),
                duration: (navigateCount == 4)
                    ? _duration
                    : Duration(microseconds: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nearMe(height, width) {
    var vert = _boxHeight('near-me', height);
    var hori = _boxWidth('near-me', width);
    bool _big;
    (hori != width) ? _big = false : _big = true;
    return AnimatedContainer(
      duration: _duration,
      height: vert,
      width: hori,
      margin:
          EdgeInsets.only(right: (navigateCount == 0) ? 0.0 : width * 3 / 5),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(_radius),
          border: Border.all(color: _shadowColor, width: 1.0),
          boxShadow: navigateCount == 0
              ? [
                  BoxShadow(
                    color: _shadowColor,
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                  )
                ]
              : [
                  BoxShadow(
                    color: _shadowColor.withOpacity(0.4),
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                  )
                ]),
      child: _nearMeMap(_big, height, width),
    );
  }

  _nearMeMap(bool big, double height, double width) {
    Completer<GoogleMapController> _controller = Completer();
    const LatLng _center = const LatLng(19.076090, 72.877426);
    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    switch (big) {
      case false:
        return Opacity(
          opacity: _opacityManager(0),
          child: Padding(
            padding: EdgeInsets.only(
              top: (height * 1 / 5 * 0.3) * 0.25,
              left: (width / 3) * 0.1,
            ),
            child: Text(
              allRoutes[0].toUpperCase(),
              style: TextStyle(
                  color: _altColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                  fontSize: _width * 1 / 2 * 0.1 * 0.8),
            ),
          ),
        );
        break;
      case true:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ],
        );
        break;
    }
  }

  Widget _kiosk(height, width) {
    var vert = _boxHeight('kiosk', height);
    var hori = _boxWidth('kiosk', width);
    bool _big;
    (hori != width) ? _big = false : _big = true;
    return AnimatedContainer(
      duration: _duration,
      height: vert,
      width: hori,
      margin:
          EdgeInsets.only(right: (navigateCount == 1) ? 0.0 : width * 3 / 5),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(_radius),
          border: Border.all(color: _shadowColor, width: 1.0),
          boxShadow: navigateCount > 1
              ? [
                  BoxShadow(
                    color: _shadowColor.withOpacity(0.4),
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                  )
                ]
              : (navigateCount < 1
                  ? [
                      BoxShadow(
                        color: _shadowColor.withOpacity(0.4),
                        offset: Offset(3, -3),
                        blurRadius: 3.0,
                      )
                    ]
                  : [
                      BoxShadow(
                        color: _shadowColor,
                        spreadRadius: 1.0,
                        blurRadius: 3.0,
                      )
                    ])),
      child: _data(_big, hori, vert, 1),
    );
  }

  Widget _primary(height, width) {
    var vert = _boxHeight('primary', height);
    var hori = _boxWidth('primary', width);
    bool _big;
    (hori != width) ? _big = false : _big = true;
    return AnimatedContainer(
      duration: _duration,
      height: vert,
      width: hori,
      margin:
          EdgeInsets.only(right: (navigateCount == 2) ? 0.0 : width * 3 / 5),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(_radius),
          border: Border.all(color: _borderColor, width: 1.0),
          boxShadow: navigateCount > 2
              ? [
                  BoxShadow(
                    color: _shadowColor.withOpacity(0.4),
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                  )
                ]
              : (navigateCount < 2
                  ? [
                      BoxShadow(
                        color: _shadowColor.withOpacity(0.4),
                        offset: Offset(3, -3),
                        blurRadius: 3.0,
                      )
                    ]
                  : [
                      BoxShadow(
                        color: _shadowColor,
                        spreadRadius: 1.0,
                        blurRadius: 3.0,
                      )
                    ])),
      child: _data(_big, hori, vert, 2),
    );
  }

  Widget _secondary(height, width) {
    var vert = _boxHeight('secondary', height);
    var hori = _boxWidth('secondary', width);
    bool _big;
    (hori != width) ? _big = false : _big = true;
    return AnimatedContainer(
      duration: _duration,
      height: vert,
      width: hori,
      margin:
          EdgeInsets.only(right: (navigateCount == 3) ? 0.0 : width * 3 / 5),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(_radius),
          border: Border.all(color: _borderColor, width: 1.0),
          boxShadow: navigateCount > 3
              ? [
                  BoxShadow(
                    color: _shadowColor.withOpacity(0.4),
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                  )
                ]
              : (navigateCount < 3
                  ? [
                      BoxShadow(
                        color: _shadowColor.withOpacity(0.4),
                        offset: Offset(3, -3),
                        blurRadius: 3.0,
                      )
                    ]
                  : [
                      BoxShadow(
                        color: _shadowColor,
                        spreadRadius: 1.0,
                        blurRadius: 3.0,
                      )
                    ])),
      child: _data(_big, hori, vert, 3),
    );
  }

  Widget _trashSpam(height, width) {
    var vert = _boxHeight('trash-spam', height);
    var hori = _boxWidth('trash-spam', width);
    bool _big;
    (hori != width) ? _big = false : _big = true;
    return AnimatedContainer(
      duration: _duration,
      height: vert,
      width: hori,
      margin:
          EdgeInsets.only(right: (navigateCount == 4) ? 0.0 : width * 3 / 5),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(_radius),
          border: Border.all(color: _borderColor, width: 1.0),
          boxShadow: navigateCount == 4
              ? [
                  BoxShadow(
                    color: _shadowColor,
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                  )
                ]
              : [
                  BoxShadow(
                    color: _shadowColor.withOpacity(0.4),
                    offset: Offset(3, -3),
                    blurRadius: 3.0,
                  )
                ]),
      child: _data(_big, hori, vert, 4),
    );
  }

  double _boxHeight(String type, double height) {
    double _sideHeight = height * 1 / 5 * 0.3;
    double _mainHeight = height * 3 / 5 + (height * 1 / 5 * 0.9);
    switch (type) {
      case 'near-me':
        if (navigateCount == 0) {
          return _mainHeight;
        } else if (navigateCount == 1) {
          return _sideHeight;
        } else {
          return 0.0;
        }
        break;
      case 'kiosk':
        if (navigateCount == 1) {
          return _mainHeight;
        } else if (navigateCount == 0 || navigateCount == 2) {
          return _sideHeight;
        } else {
          return 0.0;
        }
        break;
      case 'primary':
        if (navigateCount == 2) {
          return _mainHeight;
        } else if (navigateCount == 1 || navigateCount == 3) {
          return _sideHeight;
        } else {
          return 0.0;
        }
        break;
      case 'secondary':
        if (navigateCount == 3) {
          return _mainHeight;
        } else if (navigateCount == 2 || navigateCount == 4) {
          return _sideHeight;
        } else {
          return 0.0;
        }
        break;
      case 'trash-spam':
        if (navigateCount == 4) {
          return _mainHeight;
        } else if (navigateCount == 3) {
          return _sideHeight;
        } else {
          return 0.0;
        }
        break;
      default:
        return _sideHeight + height * 1 / 5 * 0.2;
        break;
    }
  }

  _boxWidth(String type, double width) {
    double _sideWidth = width * 2 / 5;
    double _mainWidth = width;
    switch (type) {
      case 'near-me':
        if (navigateCount == 0) {
          return _mainWidth;
        } else if (navigateCount == 1) {
          return _sideWidth;
        } else {
          return 0.0;
        }
        break;
      case 'kiosk':
        if (navigateCount == 1) {
          return _mainWidth;
        } else if (navigateCount == 0 || navigateCount == 2) {
          return _sideWidth;
        } else {
          return 0.0;
        }
        break;
      case 'primary':
        if (navigateCount == 2) {
          return _mainWidth;
        } else if (navigateCount == 1 || navigateCount == 3) {
          return _sideWidth;
        } else {
          return 0.0;
        }
        break;
      case 'secondary':
        if (navigateCount == 3) {
          return _mainWidth;
        } else if (navigateCount == 2 || navigateCount == 4) {
          return _sideWidth;
        } else {
          return 0.0;
        }
        break;
      case 'trash-spam':
        if (navigateCount == 4) {
          return _mainWidth;
        } else if (navigateCount == 3) {
          return _sideWidth;
        } else {
          return 0.0;
        }
        break;
    }
  }

  _opacityManager(int num) {
    switch (num) {
      case 0:
        return navigateCount < 2 ? 1.0 : 0.0;
        break;
      case 1:
        return navigateCount < 3 ? 1.0 : 0.0;
        break;
      case 2:
        return navigateCount > 0 ? 1.0 : 0.0;
        break;
      case 3:
        return navigateCount > 1 ? 1.0 : 0.0;
        break;
      case 4:
        return navigateCount > 2 ? 1.0 : 0.0;
        break;
    }
  }

  _data(bool big, double hori, double vert, int num) {
    switch (big) {
      case false:
        return Opacity(
          opacity: _opacityManager(num),
          child: Padding(
            padding: EdgeInsets.only(
              top: vert * 0.25,
              left: hori * 0.1,
            ),
            child: Text(
              allRoutes[num].toUpperCase(),
              style: TextStyle(
                  color: _altColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                  fontSize: _width * 1 / 2 * 0.1 * 0.8),
            ),
          ),
        );
        break;
      case true:
        switch (num) {
          case 1:

            /// For Kiosk
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: vert - 150.0,
                    width: hori * 0.95,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: hori * 0.975,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _color,
                    border: Border.all(color: _txtColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: SizedBox(
                    width: hori * 0.925,
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        text:
                            "You cannot reply to ${allRoutes[num]}\'s messages. In case, if you feel that the sender is in Trouble, please set an Alert in the Maps Section",
                        style: TextStyle(
                          color: _txtColor,
                          fontWeight: FontWeight.w400,
                          fontSize: hori * 0.1 * 0.35,
                          fontFamily: 'Calibri',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 50.0,
                  width: navigateCount == num ? hori : 0.0,
                  decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: _radius,
                        bottomRight: _radius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 30.0,
                          offset: Offset(0.0, 5.0), //(x,y)
                        )
                      ]),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: _width * 0.9,
                      alignment: Alignment.topRight,
                      child: Text(
                        allRoutes[navigateCount].toUpperCase(),
                        style: TextStyle(
                            color: _altColor,
                            letterSpacing: 5.0,
                            fontWeight: FontWeight.w700,
                            fontSize: _width * 0.975 * 0.1 * 0.9),
                      ),
                    ),
                  ),
                ),
              ],
            );
            break;
          case 4:

            /// For Trash and Spam
            break;
          default:

            /// For Primary and Secondary
            return Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  child: AnimatedContainer(
                    duration: _duration,
                    alignment: Alignment.topRight,
                    height: 30.0,
                    width: _width / 2,
                    margin: EdgeInsets.only(
                        top: 40.0 * 0.1,
                        left: _width / 2 * 0.8,
                        bottom: 40.0 * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40.0 * 0.8,
                          width: (_width / 2) * 0.4,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: _color,
                                    spreadRadius: 1.0,
                                    blurRadius: 5.0)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: ((_width / 2) * 0.4) * 0.6,
                                child: Text('Trash',
                                    style: TextStyle(
                                      color: _txtColor,
                                      letterSpacing: 2.0,
                                    ),
                                    textAlign: TextAlign.center),
                              ),
                              Icon(Icons.delete_sweep, color: _txtColor)
                            ],
                          ),
                        ),
                        SizedBox(width: (_width / 2) * 0.1),
                        Container(
                          height: 40.0 * 0.8,
                          width: (_width / 2) * 0.5,
                          decoration: BoxDecoration(
                              color: _color,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: _color,
                                    spreadRadius: 1.0,
                                    blurRadius: 5.0)
                              ]),
                          child: Center(
                            child: SizedBox(
                              width: (_width / 2) * 0.5,
                              child: Text('Select All',
                                  style: TextStyle(
                                    color: _txtColor,
                                    letterSpacing: 2.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _friendList(hori, vert, num),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: hori * 0.975,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _color,
                    border: Border.all(color: _txtColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: _shadowColor.withOpacity(0.5),
                          spreadRadius: 1.0,
                          blurRadius: 2.0)
                    ],
                  ),
                  child: SizedBox(
                    width: hori * 0.925,
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        text:
                            "Texts from your ${allRoutes[num]} connections would Pop-up here. You can dump these messages into Trash if you feel they are spamming you.",
                        style: TextStyle(
                          color: _txtColor,
                          fontWeight: FontWeight.w400,
                          fontSize: hori * 0.1 * 0.35,
                          fontFamily: 'Calibri',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 50.0,
                  width: navigateCount == num ? hori : 0.0,
                  decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: _radius,
                        bottomRight: _radius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 30.0,
                          offset: Offset(0.0, 5.0), //(x,y)
                        )
                      ]),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: _width * 0.9,
                      alignment: Alignment.topRight,
                      child: Text(
                        allRoutes[navigateCount].toUpperCase(),
                        style: TextStyle(
                            color: _altColor,
                            letterSpacing: 5.0,
                            fontWeight: FontWeight.w700,
                            fontSize: _width * 0.975 * 0.1 * 0.9),
                      ),
                    ),
                  ),
                ),
              ],
            );
            break;
        }
    }
  }

  _friendList(double hori, double vert, int num) {
    String _type;
    if (_socialProfessional) {
      _type = 'social';
    } else {
      _type = 'professional';
    }
    return Container(
      alignment: Alignment.center,
      height: vert - 150.0,
      width: hori * 0.95,
      child: ScopedModelDescendant<ChatModel>(
        builder: (context, child, model) {
          return ListView.separated(
            padding: EdgeInsets.all(0.0),
            separatorBuilder: (BuildContext context, int index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 0.5,
                  width: hori * 0.8,
                  child: Divider(),
                ),
              );
            },
            itemCount: model.friendList.length,
            itemBuilder: (BuildContext context, int index) {
              User friend = model.friendList[index];
              Map chat = chats[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(5.0),
                hoverColor: Colors.lightBlueAccent,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Scaffold(
                      body: Convo(
                        type: _type,
                        friend: friend,
                      ),
                    );
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    chat['dp'],
                  ),
                  radius: (vert - 160.0) * 1 / 6 * 0.4,
                ),
                title: Text(
                  friend.username,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: _txtColor,
                      //fontSize: (vert - 160.0) * 1 / 6 * 0.4,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  chat['msg'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: _txtColor,
                    //fontSize: (vert - 160.0) * 1 / 6 * 0.25,
                  ),
                ),
                trailing: Text(
                  chat['time'],
                  softWrap: false,
                  style: TextStyle(
                    color: _txtColor,
                    fontWeight: FontWeight.w300,
                    fontSize: (vert - 150.0) * 1 / 6 * 0.2,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _chatBubbles(index) {
    Random random = Random();
    Map msg = conversation[index];
    final String message = msg['type'] == "text"
        ? messages[random.nextInt(10)]
        : "assets/sx${random.nextInt(10)}.jpeg";
    final String time = msg["time"];
    final String username = msg["username"];
    final String type = msg['type'];
    final String replyText = msg["replyText"];
    final String replyName = names[random.nextInt(10)];
    final bool isMe = msg['isMe'];
    final bool isGroup = msg['isGroup'];
    final bool isReply = msg['isReply'];

    List colors = Colors.primaries;
    int rNum = random.nextInt(18);

    final bg = _txtColor;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: _width * 0.975 * 0.7,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              isMe
                  ? SizedBox()
                  : isGroup
                      ? Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Container(
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 13,
                                color: colors[rNum],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        )
                      : SizedBox(),
              isGroup ? isMe ? SizedBox() : SizedBox(height: 5) : SizedBox(),
              isReply
                  ? Container(
                      decoration: BoxDecoration(
                        color: !isMe ? _backColor : _backColor,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      constraints: BoxConstraints(
                        minHeight: 25,
                        maxHeight: 100,
                        minWidth: 80,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                isMe ? "You" : replyName,
                                style: TextStyle(
                                  color: _txtColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(height: 2),
                            Container(
                              child: Text(
                                replyText,
                                style: TextStyle(
                                  color: _txtColor,
                                  fontSize: 10,
                                ),
                                maxLines: 2,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(width: 2),
              isReply ? SizedBox(height: 5) : SizedBox(),
              Padding(
                padding: EdgeInsets.all(type == "text" ? 5 : 0),
                child: type == "text"
                    ? !isReply
                        ? Text(
                            message,
                            style: TextStyle(
                              color: isMe ? _backColor : _backColor,
                            ),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              message,
                              style: TextStyle(
                                color: isMe ? _backColor : _backColor,
                              ),
                            ),
                          )
                    : Image.asset(
                        "$message",
                        height: 130,
                        width: MediaQuery.of(context).size.width / 1.3,
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: isMe
              ? EdgeInsets.only(
                  right: 10,
                  bottom: 10.0,
                )
              : EdgeInsets.only(
                  left: 10,
                  bottom: 10.0,
                ),
          child: Text(
            time,
            style: TextStyle(
              color: _txtColor,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
