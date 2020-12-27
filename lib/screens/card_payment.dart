import 'package:blurbkit/widgets/forms.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPaymentPage extends StatefulWidget {
  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final _formKey = GlobalKey<FormState>();

  bool saveCard = false;

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
            fontSize: 20,
            // fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            suffixIcon: password
                ? IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
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
            // switch (fieldName) {
            //   case 'Email':
            //     _user.email = val.trim();
            //     break;
            //   case 'Phone':
            //     _user.phone = val;
            //     break;
            //   case 'First Name':
            //     _user.firstname = val.trim();
            //     break;
            //   case 'Last Name':
            //     _user.lastname = val.trim();
            //     break;
            //   case 'Stage Name':
            //     _user.stagename = val.trim();
            //     break;
            //   case 'Password':
            //     _user.password = val;
            //     break;
            // }
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
                context, '/subscription', (route) => false);
          },
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('images/atm.png'),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          bolderTextStyle('Fill your card details:',
                              fontSize: 20.0),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'CARD NUMBER',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      signUpField(
                          fieldName: '0000 \t  \t 0000 \t  \t 0000 \t  \t 0000',
                          password: false),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'EXPIRY DATE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: signUpField(
                                      fieldName: 'MM/YY', password: false),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'cvv',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: signUpField(
                                      fieldName: '000', password: false),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'CARD HOLDER NAME',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      signUpField(
                          fieldName: 'Chiroma Adekunle C.', password: false),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),

                                      // shape: BoxShape.circle,
                                      color: Colors.transparent),
                                  child: saveCard
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
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'SAVE CARD',
                                  style: TextStyle(
                                      fontWeight:
                                          saveCard ? FontWeight.bold : null),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                saveCard = !saveCard;
                              });
                            }),
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
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/index', (route) => false);
                              // print(data);
                            }),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
