import 'dart:async';
import 'dart:convert';

import 'package:blurbkit/models/user.dart';
import 'package:blurbkit/services/auth.services.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:blurbkit/widgets/notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _user = User();
  final _auth = Auth();

  bool termsAndConditions = false;

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
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
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
              case 'First Name':
                _user.firstname = val.trim();
                break;
              case 'Last Name':
                _user.lastname = val.trim();
                break;
              case 'Email':
                _user.email = val.trim();
                break;
              case 'Phone':
                _user.phone = val;
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/landing', (route) => false);
          },
        ),
        backgroundColor: Colors.grey[100],
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
                  Image.asset('images/signup.png'),
                  SizedBox(
                    height: 30,
                  ),
                  signUpField(fieldName: 'First Name', password: false),
                  signUpField(fieldName: 'Last Name', password: false),
                  signUpField(fieldName: 'Email', password: false),
                  signUpField(fieldName: 'Password', password: true),
                  signUpField(fieldName: 'Phone', password: false),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),

                              // shape: BoxShape.circle,
                              color: Colors.transparent),
                          child: termsAndConditions
                              ? Icon(
                                  Icons.check_box,
                                  size: 25.0,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                        ),
                        // Checkbox(
                        //   value: termsAndConditions,
                        //   onChanged: (value) {
                        //     // print('clicke');
                        //     setState(() {
                        //       termsAndConditions = value;
                        //     });
                        //     return value;
                        //   },
                        //   activeColor: Colors.black,
                        //   focusColor: Colors.grey,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            child: Text(
                              'I agree to the terms and conditions',
                              style: TextStyle(
                                  fontWeight: termsAndConditions
                                      ? FontWeight.bold
                                      : null),
                            ),
                            onTap: () {
                              setState(() {
                                termsAndConditions = !termsAndConditions;
                              });
                            }),
                      ],
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
                        child: boldTextStyle('Signup'),
                        onPressed: () {
                          FocusScope.of(context).unfocus(); // hide the keypad

                          final form = _formKey.currentState;
                          if (form.validate()) {
                            
                            if (!termsAndConditions) {
                              errorNotification(
                                  'First agree with our terms and conditions ...');
                              return false;
                            }
                            showLoader();
                            form.save();
                            _auth.createUser(_user).then((res) {
                              hideLoader();
                              print(res.statusCode);
                              print(json.decode(res.body));
                              // print(res.error);
                              if (res.statusCode == 201) {
                                print('successful o');
                                successNotification('Signup Successful!');
                                // send token to activate token
                                // Navigate to account verification
                                Navigator.pushNamed(context, '/login');
                              } else if ([400, 422].contains(res.statusCode)) {
                                var response = json.decode(res.body);
                                var errors = '';
                                for (var values in response.values) {
                                  print(values[0]);
                                  errors += '- ' + values[0] + '\n';
                                }
                                errorNotification(errors);

                              } else {
                                errorNotification(res.statusCode);
                              }
                            }).catchError((onError) {
                              hideLoader();
                              print('catch Error');
                              errorNotification(onError);
                            });
                          }
                          // BotToast.closeAllLoading();
                        }),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Have an account already?',
                        ),
                        SizedBox(
                          width: 60,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/login',
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
