import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/logo.png'),
                      Image.asset('images/Blurbkit.png'),
                      boldTextStyle(
                          'Read or listen to summarized books from the comfort of your phone'),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
              Image.asset(
                'images/books/books_display.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                            // elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: appColor(),
                            textColor: Colors.white,
                            child: boldTextStyle('Signup'),
                            onPressed: () {
                              // print(data);
                              Navigator.pushNamed(context, '/signup');
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                            // elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: Colors.white,
                            textColor: Colors.black,
                            child: boldTextStyle('Login'),
                            onPressed: () {
                              print('login');
                              Navigator.pushNamed(context, '/login');
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
