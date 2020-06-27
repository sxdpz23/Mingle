import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:citoto/utilities/data.dart';
import 'package:citoto/widgets/chats.dart';

///
/// Hello this is just an index of all the things to let you help navigate.
///
/// Use the below keywords to FIND the function or classes -
///

class Convo extends StatefulWidget {
  final String type;
  final User friend;

  const Convo({Key key, this.type, this.friend}) : super(key: key);

  @override
  _ConvoState createState() => _ConvoState();
}

class _ConvoState extends State<Convo> {
  Duration _duration = Duration(milliseconds: 500);

  var _socialProfessional;
  User _currentUser;
  double _inChatOptionsHeight;
  bool _chatOptions = false;
  String _inChatOptions = '';

  var _height;
  var _width;
  Color _color;
  Color _altColor;
  Color _txtColor;
  Color _backColor;
  Color _shadowColor;
  final Radius _radius = Radius.circular(30.0);

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'social':
        setState(() {
          _socialProfessional = true;
        });
        break;
      case 'professional':
        setState(() {
          _socialProfessional = false;
        });
    }

    if (_socialProfessional == true) {
      setState(() {
        _backColor = Colors.white;
        _txtColor = Colors.black;
        _color = Colors.white;
        _shadowColor = Colors.black.withOpacity(0.5);
        _altColor = _txtColor;
        //_altColor = _txtColor.withAlpha(0x88);
      });
    } else {
      setState(() {
        _color = Color.fromARGB(0xCC, 51, 62, 80);
        _txtColor = Colors.white;
        _backColor = Colors.black;
        _shadowColor = Colors.black.withOpacity(0.4);
        //_altColor = _txtColor;
        _altColor = _txtColor;
      });
    }

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: _backColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                height: _height,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: (_height * 1 / 6 * 0.45)),
                    Container(
                      height: _height * 0.9,
                      width: _width * 0.975,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _color,
                          borderRadius: BorderRadius.only(
                            topLeft: _radius,
                            topRight: _radius,
                            bottomRight: _radius,
                            bottomLeft: _radius,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _shadowColor.withOpacity(0.4),
                              blurRadius: 5.0,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _titleBar(_height * 0.9, _width * 0.975),
                          _viewChats(_height * 0.9, _width * 0.975),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: inBetweenSpace(_width),
                right: 0.0,
                child: _sideOptions(_height, _width),
              ),
            ],
          ),
        ));
  }

  Widget _titleBar(double height, double width) {
    List<String> name = widget.friend.username.toUpperCase().split(' ');

    return Container(
      alignment: Alignment.topCenter,
      width: width,
      height: 70.0,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: _width * 0.925,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 15.0,
              left: width * 0.05,
              child: GestureDetector(
                onTap: () {
                  /// Navigation to profile page
                  print('Name Tapped');
                },
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: _txtColor,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Times-New-Roman',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: name[0][0], style: TextStyle(fontSize: 30.0)),
                        TextSpan(
                            text: name[0].substring(1) + ' ',
                            style: TextStyle(fontSize: 20.0)),
                        TextSpan(
                            text: name[1][0], style: TextStyle(fontSize: 30.0)),
                        TextSpan(
                            text: name[1].substring(1) + ' ',
                            style: TextStyle(fontSize: 20.0))
                      ]),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Positioned(
              right: 20.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                width: 60.0 * 0.8,
                height: 60.0 * 0.8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _txtColor, width: 1.0)),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/sx${random.nextInt(10)}.jpeg",
                    ),
                    radius: 22.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewChats(double height, double width) {
    height = height - 80.0;
    width = _width;
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            chats(height, width * 0.925),
            Container(
              alignment: Alignment.bottomCenter,
              width: width,
              height: (_chatOptions ? _inChatOptionsHeight : 0.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: _box(height * 1 / 3, width * 0.925),
            )
          ],
        ),
      ),
    );
  }

  Widget chats(double height, double width) {
    /// Chatting Page
    return ScopedModelDescendant<ChatModel>(builder: (context, child, model) {
      List<Message> messages =
          model.getMessagesForCitotoID(widget.friend.citID);

      return Container(
        alignment: Alignment.topCenter,
        height: _chatOptions ? height - _inChatOptionsHeight : height,
        width: width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _color,
            borderRadius: BorderRadius.all(_radius)),
        child: ListView.builder(
          itemCount: messages.length,
          reverse: false,
          itemBuilder: (BuildContext context, int index) {
            //return _chatBubbles(index);
            return buildSingleMessage(messages[index], index);
          },
        ),
      );
    });
  }

  Widget buildSingleMessage(Message message, int ind) {
    bool isMe;
    (message.senderCitotoID == widget.friend.citID)
        ? isMe = false
        : isMe = true;
    Radius radi = Radius.circular(8.0);
    double width = _width * 0.25;
    Map notif = notifications[ind];
    return Container(
      margin: isMe
          ? EdgeInsets.fromLTRB(width, 10, 10, 10)
          : EdgeInsets.fromLTRB(10, 10, width, 10),
      width: _width * 0.925,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isMe
              ? SizedBox()
              : Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          notif['dp'],
                        ),
                        radius: width * 0.3 * 0.5,
                      ),
                      SizedBox(width: 10.0)
                    ],
                  ),
                ),
          Expanded(
            child: AnimatedContainer(
              duration: _duration,
              width: _width - width - width * 0.1 * 0.5,
              alignment: !isMe ? Alignment.centerLeft : Alignment.centerRight,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: _txtColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: _radius,
                    bottomLeft: isMe ? _radius : radi,
                    topRight: _radius,
                    bottomRight: !isMe ? _radius : radi,
                  )),
              child: Text(
                message.text,
                softWrap: true,
                textAlign: !isMe ? TextAlign.left : TextAlign.right,
                style: TextStyle(
                  color: _backColor,
                ),
              ),
            ),
          ),
          !isMe
              ? SizedBox()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          notif['dp'],
                        ),
                        radius: width * 0.3 * 0.5,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  TextEditingController _messageController = TextEditingController();

  /// Message Controller to listen what is getting typed in Message Box

  Widget _box(double height, double width) {
    switch (_inChatOptions) {
      case 'more':
        return Row(
          children: <Widget>[
            Container(
              height: height * 0.95,
              width: width * 0.95 * 7 / 8,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(
                color: _txtColor.withOpacity(0.5),
                width: 1.0,
              ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('Blocked XD');
                    },
                    child: Container(
                      height: height * 0.95 * 0.6 / 3,
                      width: width * 0.95 * 7 / 8 * 0.9,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(_radius),
                          border: Border.all(
                            color: _txtColor,
                            width: 2.0,
                          )),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: _txtColor,
                                letterSpacing: 1.0,
                                fontSize: width * 0.1 * 0.4,
                                fontFamily: 'Calibri',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'B',
                                    style: TextStyle(
                                      fontSize: width * 0.1 * 0.6,
                                    )),
                                TextSpan(text: 'LOCK'),
                                TextSpan(
                                    text: ' & R',
                                    style: TextStyle(
                                      fontSize: width * 0.1 * 0.6,
                                    )),
                                TextSpan(text: 'EPORT'),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.95 * 0.1),
                  GestureDetector(
                    onTap: () {
                      print('Cleared XD');
                    },
                    child: Container(
                      height: height * 0.95 * 0.6 / 3,
                      width: width * 0.95 * 7 / 8 * 0.9,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(_radius),
                          border: Border.all(
                            color: _txtColor,
                            width: 2.0,
                          )),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: _txtColor,
                                letterSpacing: 1.0,
                                fontSize: width * 0.1 * 0.4,
                                fontFamily: 'Calibri',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'C',
                                    style: TextStyle(
                                      fontSize: width * 0.1 * 0.6,
                                    )),
                                TextSpan(text: 'LEAR'),
                                TextSpan(
                                    text: ' C',
                                    style: TextStyle(
                                      fontSize: width * 0.1 * 0.6,
                                    )),
                                TextSpan(text: 'HAT'),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: width * 0.04),
            Container(
              height: height * 0.95,
              width: width * 0.95 / 8,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: _backColor,
                              letterSpacing: 2.0,
                              fontSize: 35.0,
                              fontFamily: 'Calibri',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'M', style: TextStyle(fontSize: 50.0)),
                            TextSpan(text: 'ORE...')
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case 'attachment':
        return Row(
          children: <Widget>[
            Container(
              height: height * 0.95,
              width: width * 0.95 * 10 / 11,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(
                color: _txtColor.withOpacity(0.5),
                width: 1.0,
              ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: height * 0.95 * 0.9 / 2,
                    width: width * 0.95 * 11 / 12 * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 1 / 4 * 1 / 3),
                        _attachments(
                            (height * 0.95 * 0.9 / 2),
                            (width * 0.95 * 11 / 12 * 0.9),
                            Icons.photo,
                            Colors.blue,
                            'Photo'),
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 1 / 4 * 1 / 3),
                        _attachments(
                            (height * 0.95 * 0.9 / 2),
                            (width * 0.95 * 11 / 12 * 0.9),
                            Icons.audiotrack,
                            Colors.deepOrange,
                            'Audio'),
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 1 / 4 * 1 / 3),
                        _attachments(
                            (height * 0.95 * 0.9 / 2),
                            (width * 0.95 * 11 / 12 * 0.9),
                            Entypo.documents,
                            Colors.blueGrey,
                            'Document'),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.95 * 0.1 * 1 / 3),
                  Container(
                    height: height * 0.95 * 0.9 / 2,
                    width: width * 0.95 * 11 / 12 * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 2 / 4 * 2 / 4),
                        _attachments(
                            (height * 0.95 * 0.9 / 2),
                            (width * 0.95 * 11 / 12 * 0.9),
                            Icons.add_location,
                            Colors.green,
                            'Location'),
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 2 / 4 * 1 / 4),
                        _attachments(
                            (height * 0.95 * 0.9 / 2),
                            (width * 0.95 * 11 / 12 * 0.9),
                            Icons.person,
                            _backColor,
                            'Profile'),
                        SizedBox(
                            width:
                                (width * 0.95 * 11 / 12 * 0.9) * 2 / 4 * 1 / 4),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.95 * 0.1 * 1 / 3),
                ],
              ),
            ),
            SizedBox(width: width * 0.04),
            Container(
              height: height * 0.95,
              width: width * 0.95 / 12,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: _backColor,
                              letterSpacing: 2.0,
                              fontSize: 20.0,
                              fontFamily: 'Calibri',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'A', style: TextStyle(fontSize: 35.0)),
                            TextSpan(text: 'TTACHMENTS...')
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case 'message':
        return ScopedModelDescendant<ChatModel>(
            builder: (context, child, model) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: width * 0.2 / 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: width * 0.8,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: _txtColor,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 35.0,
                          width: width * 0.8 * 0.9,
                          child: TextField(
                            controller: _messageController,
                            keyboardType: TextInputType.text,
                            onSubmitted: (msg) {
                              print("Message Submitted");
                              setState(() {
                                model.sendMessage(msg, widget.friend.citID);
                                _messageController.text = '';
                              });
                            },
                            style: TextStyle(
                              color: _backColor,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //contentPadding: EdgeInsets.only(top: 14.0),
                              hintText: 'Type your message here',
                              hintStyle: TextStyle(
                                  color: _color, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.1 * 0.1),
                    IconButton(
                      icon: Icon(Feather.send,
                          color: _socialProfessional
                              ? Colors.green
                              : Colors.greenAccent),
                      iconSize: width * 0.1 * 0.9,
                      onPressed: () {
                        print("Tapped Send");
                        setState(() {
                          model.sendMessage(
                              _messageController.text, widget.friend.citID);
                          _messageController.text = '';
                        });
                      },
                    )
                  ],
                ),
                SizedBox(width: width * 0.2 / 6),
              ],
            ),
          );
        });
        break;
      default:
        return SizedBox();
        break;
    }
  }

  Widget _sideOptions(double height, double width) {
    return AnimatedContainer(
      duration: _duration,
      height: _chatOptions ? 50.0 : 200.0 + (width * 0.8 / 6),
      width: width / 6,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              /// More Info
              duration: _duration,
              height:
                  _chatOptions ? (_inChatOptions == 'more' ? 50.0 : 0.0) : 50.0,
              width: _chatOptions
                  ? (_inChatOptions == 'more' ? width * 1 / 6 : 0.0)
                  : width * 1 / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _txtColor,
              ),
              child: Center(
                  child: IconButton(
                icon: Icon(Icons.settings, color: _backColor),
                iconSize: _chatOptions
                    ? (_inChatOptions == 'more' ? width * 0.1 * 0.8 : 0.0)
                    : width * 0.1 * 0.8,
                onPressed: () {
                  setState(() {
                    if (_chatOptions) {
                      _chatOptions = false;
                      _inChatOptions = '';
                    } else {
                      _chatOptions = true;
                      _inChatOptions = 'more';
                      _inChatOptionsHeight = height * 1 / 4;
                    }
                  });
                },
              )),
            ),
            SizedBox(height: _chatOptions ? 0.0 : width * 0.2 / 6),
            AnimatedContainer(
              /// Attachments
              duration: _duration,
              height: _chatOptions
                  ? (_inChatOptions == 'attachment' ? 50.0 : 0.0)
                  : 50.0,
              width: _chatOptions
                  ? (_inChatOptions == 'attachment' ? width * 1 / 6 : 0.0)
                  : width * 1 / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _txtColor,
              ),
              child: Center(
                  child: IconButton(
                icon: Icon(Entypo.attachment, color: _backColor),
                iconSize: _chatOptions
                    ? (_inChatOptions == 'attachment' ? width * 0.1 * 0.8 : 0.0)
                    : width * 0.1 * 0.8,
                onPressed: () {
                  setState(() {
                    if (_chatOptions) {
                      if (_inChatOptions == 'attachment') {
                        _chatOptions = false;
                        _inChatOptions = '';
                      } else {
                        _chatOptions = true;
                        _inChatOptions = 'attachment';
                        _inChatOptionsHeight = height * 1 / 4;
                      }
                    } else {
                      _chatOptions = true;
                      _inChatOptions = 'attachment';
                      _inChatOptionsHeight = height * 1 / 4;
                    }
                  });
                },
              )),
            ),
            SizedBox(height: _chatOptions ? 0.0 : width * 0.2 / 6),
            AnimatedContainer(
              /// Messages
              duration: _duration,
              height: _chatOptions
                  ? (_inChatOptions == 'message' ? 50.0 : 0.0)
                  : 50.0,
              width: _chatOptions
                  ? (_inChatOptions == 'message' ? width * 1 / 6 : 0.0)
                  : width * 1 / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _txtColor,
              ),
              child: Center(
                  child: IconButton(
                icon: Icon(Icons.message, color: _backColor),
                iconSize: _chatOptions
                    ? (_inChatOptions == 'message' ? width * 0.1 * 0.8 : 0.0)
                    : width * 0.1 * 0.8,
                onPressed: () {
                  setState(() {
                    if (_chatOptions) {
                      _chatOptions = false;
                      _inChatOptions = '';
                    } else {
                      _chatOptions = true;
                      _inChatOptions = 'message';
                      _inChatOptionsHeight = 70.0;
                    }
                  });
                },
              )),
            ),
            SizedBox(height: _chatOptions ? 0.0 : width * 0.2 / 6),
            Opacity(
              opacity: _chatOptions ? 0 : 1,
              child: Container(
                /// Back
                height: _chatOptions ? 0.0 : 50.0,
                width: width * 1 / 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _txtColor,
                ),
                child: Center(
                    child: IconButton(
                  icon: Icon(
                      _chatOptions
                          ? Icons.keyboard_arrow_down
                          : Icons.arrow_back_ios,
                      color: _backColor),
                  iconSize: _chatOptions ? width * 0.1 : width * 0.1 * 0.7,
                  onPressed: () {
                    setState(() {
                      if (_chatOptions) {
                        _chatOptions = false;
                        _inChatOptions = '';
                      } else {
                        Navigator.pop(context);
                      }
                    });
                  },
                )),
              ),
            ),
            SizedBox(height: _chatOptions ? 0.0 : width * 0.2 / 6),
          ],
        ),
      ),
    );
  }

  double inBetweenSpace(double width) {
    switch (_inChatOptions) {
      case 'more':
        return ((_height - 70.0) * 1 / 4);
        break;
      case 'attachment':
        return ((_height - 70.0) * 1 / 4);
        break;
      case 'message':
        return ((_height - 70.0) * 1 / 9);
        break;
      default:
        return (width * 0.2 / 6);
        break;
    }
  }

  Widget _attachments(
      double height, double width, IconData icon, Color color, String type) {
    return Container(
      width: width * 1 / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: height * 0.8 * 2 / 3,
            width: height * 0.8 * 2 / 3,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color,
                borderRadius: BorderRadius.all(_radius)),
            child: Center(
              child: Icon(
                icon,
                color: _txtColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.1),
          SizedBox(
            child: Text(
              type,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _txtColor, letterSpacing: 1.0, fontFamily: 'Calibri'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
