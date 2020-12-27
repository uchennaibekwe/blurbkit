import 'package:blurbkit/screens/home.dart';
import 'package:blurbkit/screens/library.dart';
import 'package:blurbkit/screens/search.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final bookmark = List<bool>.generate(3, (i) => false);
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[400],
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    Widget child;

    switch (_index) {
      case 0:
        child = SearchPage();
        break;
      case 1:
        child = HomePage();
        break;
      case 2:
        child = LibraryPage();
        break;
    }
    return Scaffold(
      appBar: _index != 0 ? AppBar(
        leading: Container(),
        actions: _index == 1 ? <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.settings,
              color: appColor(),
            ),
          )
        ] : _index == 2 ? <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.edit,
              color: appColor(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.format_align_right,
              color: appColor(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: appColor(),
            ),
          ),
        ] : [],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) : AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: child,
      extendBodyBehindAppBar: _index == 0 ? true : false,
      bottomNavigationBar: SizedBox(
        height: 55,
        child: BottomNavigationBar(
          iconSize: 25,
          backgroundColor: appColor(),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.white30,
          fixedColor: Colors.white,
          currentIndex: _index,
          onTap: (newIndex) => setState(() => _index = newIndex),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), title: Text('Bookmarks')),
          ],
        ),
      ),
    );
  }
}
