import 'dart:convert';

import 'package:blurbkit/models/user.dart';
import 'package:blurbkit/services/auth.services.dart';
import 'package:blurbkit/utils/general.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:blurbkit/widgets/notifications.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _user = User();
  final _auth = Auth();

  bool passwordVisible = false;
  bool obscureText = true;

  signUpField<Widget>({String fieldName, bool password}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        // elevation: 3,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
        child: TextFormField(
          enableSuggestions: true,
          keyboardType: fieldName == 'Phone' ? TextInputType.phone : null,
          textCapitalization: TextCapitalization.words,
          obscureText: password ? obscureText : false,
          style: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            suffixIcon: password
                ? IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: Colors.grey[500],
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                        obscureText = !obscureText;
                      });
                    })
                : null,
            hintText: fieldName,
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) return 'This field is required!';

            if (fieldName == 'Email') {
              if (!EmailValidator.validate(value.trim()))
                return 'Invalid Email Address!';
            }
            return null;
          },
          onSaved: (val) => setState(() {
            switch (fieldName) {
              case 'Email':
                _user.email = val.trim();
                break;
              case 'Password':
                _user.password = val;
                break;
            }
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: appColor(),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/landing', (route) => false);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/login.png'),
                  SizedBox(
                    height: 30,
                  ),
                  signUpField(fieldName: 'Email', password: false),
                  signUpField(fieldName: 'Password', password: true),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          'Forgotten Password?',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/passwordreset');
                        });
                      },
                    ),
                  ),
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
                        child: boldTextStyle('Login'),
                        onPressed: () {
                          // print(data); 
                          // Navigator.pushNamed(context, '/index');
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            FocusScope.of(context).unfocus(); // hide the keypad
                            form.save();
                            showLoader();

                            _auth.login(_user).then((res) async {
                              hideLoader();
                              if (res.statusCode == 200) {
                                print('login successful!');

                                print(json.decode(res.body)['access']);
                                var access = json.decode(res.body)['access'];
                                await storage.write(
                                    key: 'token', value: access);
                                Navigator.pushNamed(context, '/index');

                                // alert(context, access);
                              } else if (res.statusCode == 401) {
                                var error = json.decode(res.body)['detail'];
                                errorNotification('$error');
                              } else {
                                // error occurred
                                print('An error occurred!');
                                errorNotification(
                                    'Error: ${res.statusCode} Occurred');
                              }
                            }).catchError((error) {
                              hideLoader();
                              errorNotification('$error');
                            });
                          }
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, '/subscription', (route) => false);
                        }),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                        ),
                        SizedBox(
                          width: 60,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/signup',
                                arguments: '',
                              );
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        )
                      ]),
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: FlatButton(
                  //       // elevation: 3.0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(5.0),
                  //       ),
                  //       color: Colors.white,
                  //       textColor: Colors.black,
                  //       child: boldTextStyle('Login'),
                  //       onPressed: () {
                  //         // Navigator.pushNamed(context, '/signup', arguments: 1);
                  //       }),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ]),
          ),
        ),
      ),
    );
  }
}
