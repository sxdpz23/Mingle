import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:citoto/screens/mingle.dart';
import 'package:citoto/widgets/read-write-file.dart';

class Login extends StatefulWidget {
  @override
  _LoggingState createState() => _LoggingState();
}

class _LoggingState extends State<Login> {
  double _height;
  double _width;
  TextEditingController _idController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final Storage _storage = Storage();

  final sxHintTextStyleSocial =
      TextStyle(color: Colors.black54, fontFamily: 'OpenSans');
  final sxHintTextStyleProfessional =
      TextStyle(color: Colors.white, fontFamily: 'OpenSans');
  final sxLabelStyleSocial = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  final sxLabelStyleProfessional = TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  final sxBoxDecorationStyle = BoxDecoration(
    color: Color(0xFF6CA8F1),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  final sxSearchBarDecorationSocial = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(0.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  final sxSearchBarDecorationProfessional = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(0.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  final sxSearchBarIconDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(100.0),
  );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: _loggingIn()),
    );
  }

  Widget _loggingIn() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Image(
              //   image: AssetImage("assets/pattern.jpeg"),
              //   fit: BoxFit.cover,
              //   colorBlendMode: BlendMode.darken,
              //   color: Colors.white70,
              // ),
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: _height * 0.9,
                width: _width * 0.95,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlutterLogo(
                          size: _width * 0.4,
                        ),
                        SizedBox(height: 30.0),
                        _buildCitotoIDTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildLoginBtn(),
                        _buildSignupText(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _buildSignupBtn(),
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

  Widget _buildCitotoIDTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Citoto ID',
          style: sxLabelStyleSocial,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: sxBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _idController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Enter your Citoto ID',
              hintStyle: sxHintTextStyleSocial,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: sxLabelStyleSocial,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: sxBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Enter your Password',
              hintStyle: sxHintTextStyleSocial,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: sxLabelStyleSocial,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _loginAction(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.black,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  _loginAction() {
    print('Login Button Pressed');
    final String citotoID = _idController.text;
    final String password = _passController.text;
    print('Citoto \nID- $citotoID\nPASSWORD - $password');
    _storage.writeFile(citotoID);
    Route _route = MaterialPageRoute(
        builder: (context) => Mingle(
              citID: citotoID,
            ));
    Navigator.pushReplacement(context, _route);
  }

  Widget _buildSignupText() {
    return GestureDetector(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print("Sign in Button Clicked"),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Sign Up from Our Site',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
