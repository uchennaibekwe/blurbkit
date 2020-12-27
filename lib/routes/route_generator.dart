import 'package:blurbkit/screens/book_description.dart';
import 'package:blurbkit/screens/card_payment.dart';
// import 'package:blurbkit/screens/home.dart';
import 'package:blurbkit/screens/index.dart';
import 'package:blurbkit/screens/landingpage.dart';
import 'package:blurbkit/screens/login.dart';
import 'package:blurbkit/screens/password_reset.dart';
import 'package:blurbkit/screens/playbook.dart';
import 'package:blurbkit/screens/readbook.dart';
import 'package:blurbkit/screens/signup.dart';
import 'package:blurbkit/screens/subscription.dart';
import 'package:blurbkit/screens/walkscreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/intro':
        return MaterialPageRoute(builder: (_) => WalkScreen());
      case '/landing':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/passwordreset':
        return MaterialPageRoute(builder: (_) => PasswordResetPage());
      case '/emailconfirmation':
        return MaterialPageRoute(builder: (_) => EmailConfirmationPage(email: args));
      case '/subscription':
        return MaterialPageRoute(builder: (_) => SubscriptionPage());
      case '/cardpayment':
        return MaterialPageRoute(builder: (_) => CardPaymentPage());
      case '/index':
        return MaterialPageRoute(builder: (_) => IndexPage());
      case '/bookdescription':
        return MaterialPageRoute(builder: (_) => BookDescriptionPage(book: args));
      case '/readbook':
        return MaterialPageRoute(builder: (_) => ReadBookPage(book: args));
      case '/playbook':
        return MaterialPageRoute(builder: (_) => PlayBookPage(book: args));
      default:
        // If no such named rout in the switch statement,
        return _errorRoute('Error');
    }
  }

  static Route<dynamic> _errorRoute(msg) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text('Error'),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  size: 70,
                  color: Colors.grey,
                ),
                // Text("${snapshot.error}."),
                SizedBox(
                  height: 5,
                ),
                Text("$msg",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 16
                        // size
                        )),
                Text("Ensure you're connnected to the internet",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    )),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                    color: Colors.red[900],
                    textColor: Colors.white,
                    child: Text('HOME'),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/index', (route) => false);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
