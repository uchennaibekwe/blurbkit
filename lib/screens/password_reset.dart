import 'dart:convert';

import 'package:blurbkit/services/auth.services.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:blurbkit/widgets/notifications.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = Auth();

  String email;
  emailField<Widget>({String fieldName, bool password}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        // elevation: 3,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
        child: TextFormField(
          enableSuggestions: true,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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
            email = val.trim();
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
            Navigator.pop(context);
            // Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
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
                  Image.asset('images/passwordreset.png'),
                  SizedBox(
                    height: 30,
                  ),
                  bolderTextStyle('Forgot Password?', fontSize: 18.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 15),
                    child: Text(
                      'Enter your email below to reset your password',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  emailField(fieldName: 'Email', password: false),
                  SizedBox(
                    height: 6,
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
                        child: boldTextStyle('Confirm'),
                        onPressed: () {
                          FocusScope.of(context).unfocus(); // hide the keypad
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            showLoader();
                            _auth.sendToken(email).then((res) {
                              print(res.statusCode);
                              print(json.decode(res.body));

                              hideLoader();
                              if ([200, 201].contains(res.statusCode)) {
                                successNotification('Token Sent!');
                                
                                Navigator.pushNamed(context, '/emailconfirmation',
                                    arguments: email);
                              } else if ([400, 404, 422]
                                  .contains(res.statusCode)) {
                                var response = json.decode(res.body);
                                // var errors = '';
                                // for (var values in response.values) {
                                //   print(values[0]);
                                //   errors += '- ' + values[0] + '\n';
                                // }
                                errorNotification(response['message']);
                              } else {
                                errorNotification(
                                    'Error ${res.statusCode} occurred!');
                              }
                            }).catchError((onError) {
                              hideLoader();
                              errorNotification('$onError');
                            });
                          }
                          // Navigator.pushNamed(context, '/emailconfirmation');
                        }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class EmailConfirmationPage extends StatefulWidget {
  final email;
  EmailConfirmationPage({@required this.email});
  @override
  EmailConfirmationPageState createState() => EmailConfirmationPageState();
}

class EmailConfirmationPageState extends State<EmailConfirmationPage> {
  final _formKey = GlobalKey<FormState>();

  // final _user = User();
  final _auth = Auth();
  String token;
  String newPassword;

  bool passwordVisible = false;
  bool obscureText = true;

  resetField<Widget>({String fieldName, bool password}) {
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
              case 'Token':
                token = val.trim();
                break;
              case 'New Password':
                newPassword = val;
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
                context, '/login', (route) => false);
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
                Image.asset('images/email_confirmation.png'),
                SizedBox(
                  height: 30,
                ),
                bolderTextStyle(
                    'Kindly check "${widget.email.toString().toLowerCase()}" for the token sent to you',
                    fontSize: 18.0),
                SizedBox(
                  height: 30,
                ),
                resetField(fieldName: 'Token', password: false),
                SizedBox(
                  height: 6,
                ),
                resetField(fieldName: 'New Password', password: true),
                SizedBox(
                  height: 6,
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
                      child: boldTextStyle('Change Password'),
                      onPressed: () {
                        FocusScope.of(context).unfocus(); // hide the keypad
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          showLoader();
                          _auth.resetPassword(token, newPassword).then((res) {
                            print(res.statusCode);

                            hideLoader();
                            if ([200, 201].contains(res.statusCode)) {
                              // password changed
                              successNotification('Password Changed');
                              print(json.decode(res.body));
                              // redirect to the login page
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            } else if ([400, 404, 422]
                                .contains(res.statusCode)) {
                              var response = json.decode(res.body);
                              errorNotification(response['errors']);
                            } else {
                              errorNotification(
                                  'Error ${res.statusCode} occurred!');
                            }
                          }).catchError((onError) {
                            hideLoader();
                            errorNotification('$onError');
                            // errorNotification(onError);
                          });
                        }
                      }),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t get the token? ',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                            child: Text(
                              ' Resend',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              showLoader();
                              _auth.sendToken(widget.email).then((res) {
                                print(res.statusCode);
                                print(json.decode(res.body));

                                hideLoader();
                                if ([200, 201].contains(res.statusCode)) {
                                  successNotification('Send');
                                } else if ([400, 404, 422]
                                    .contains(res.statusCode)) {
                                  var response = json.decode(res.body);
                                  // var errors = '';
                                  // for (var values in response.values) {
                                  //   print(values[0]);
                                  //   errors += '- ' + values[0] + '\n';
                                  // }
                                  errorNotification(response['message']);
                                } else {
                                  errorNotification(
                                      'Error ${res.statusCode} occurred!');
                                }
                              }).catchError((onError) {
                                hideLoader();
                                errorNotification('$onError');
                              });
                            }),
                      ],
                    ),
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
