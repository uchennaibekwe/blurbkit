import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     color: appColor(),
      //     onPressed: () {
      //       Navigator.pushNamedAndRemoveUntil(
      //           context, '/login', (route) => false);
      //     },
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Image.asset('images/subscription.png'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: boldTextStyle(
                      'Select a subscription plan below to start enjoying all the features on smart read.'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 3.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              Container(
                                color: Colors.teal,
                                height: 25,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Center(
                                    child: Text(
                                      '10% OFF',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 90,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: boldTextStyle('Billed Quarterly',
                                fontSize: 14.0),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                  text: '₦2,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '/month',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ]),
                            ),
                            SizedBox(
                              height: 25,
                              width: 95,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  // elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  color: appColor(),
                                  textColor: Colors.white,
                                  child: boldTextStyle('Subscribe',
                                      fontSize: 13.0),
                                  onPressed: () {
                                    // print(data);
                                    Navigator.pushNamed(
                                        context, '/cardpayment');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              Container(
                                color: Colors.teal,
                                height: 25,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Center(
                                    child: Text(
                                      '10% OFF',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 90,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: boldTextStyle('Billed Annually',
                                fontSize: 14.0),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                  text: '₦1,500',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '/month',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ]),
                            ),
                            SizedBox(
                              height: 25,
                              width: 95,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  // elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  color: appColor(),
                                  textColor: Colors.white,
                                  child: boldTextStyle('Subscribe',
                                      fontSize: 13.0),
                                  onPressed: () {
                                    // print(data);
                                    Navigator.pushNamed(
                                        context, '/cardpayment');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              Container(
                                color: Colors.teal,
                                height: 25,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Center(
                                    child: Text(
                                      '10% OFF',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 90,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child:
                                boldTextStyle('Billed Monthly', fontSize: 14.0),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                  text: '₦1,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '/month',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ]),
                            ),
                            SizedBox(
                              height: 25,
                              width: 95,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  // elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  color: appColor(),
                                  textColor: Colors.white,
                                  child: boldTextStyle('Subscribe',
                                      fontSize: 13.0),
                                  onPressed: () {
                                    // print(data);
                                    Navigator.pushNamed(
                                        context, '/cardpayment');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                      // elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: appColor(),
                      textColor: Colors.white,
                      child: boldTextStyle('Explore for now'),
                      onPressed: () {
                        print('clicked');
                        Navigator.pushNamed(context, '/index');
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/home', (route) => false);
                        // print(data);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
