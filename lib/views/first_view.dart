import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_man_startup/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: _height * 0.10),
                Text('Welcome', style: TextStyle(fontSize: 44, color: Colors.white)),
                SizedBox(height: _height * 0.10),
                AutoSizeText(
                  "Let's start planning your next trip",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(height: _height * 0.10),
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      'Get Started',
                      style:
                          TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        description:
                            'With account your data will be securely saved, allowing to get them only for you',
                        title: 'Would you like to create a free account?',
                        primaryButtonRoute: '/signUp',
                        primaryButtonText: 'Create My Account',
                        secondaryButtonRoute: '/anonymousSignIn',
                        secondaryButtonText: 'Maybe Later',
                      ),
                    );
                  },
                ),
                SizedBox(height: _height * 0.05),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                  child: Text(
                    'Sing In',
                    style:
                        TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
