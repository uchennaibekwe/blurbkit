import 'package:blurbkit/models/book.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/material.dart';

class ReadBookPage extends StatefulWidget {
  final Book book;
  ReadBookPage({this.book});

  @override
  _ReadBookPageState createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  int pageNumber = 1;
  final _pageController = PageController(initialPage: 0, keepPage: true);

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: appSecondaryColor(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  child: Text(
                    'Page $pageNumber',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.play_arrow,
                  color: appColor(),
                ),
              ),
              onTap: () {
                _pageController.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.easeInCubic);
              }),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.font_download,
              color: appColor(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.more_vert,
              color: appColor(),
            ),
          ),
        ],
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: PageView(
          controller: _pageController,
          onPageChanged: (number) {
            // TODO: stop any audio playing and start paying the page audio.
            print('Page Changed $number');
          },
          children: [
            Text('First Page'),
            Text('Second Page'),
            Text('Third Page'),
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       bolderTextStyle('${widget.book.title.toUpperCase()}',
      //           fontSize: 18.0),
      //       SizedBox(
      //         height: 3,
      //       ),
      //       bolderTextStyle('${widget.book.author ?? 'Anonymous'}',
      //           fontSize: 16.0),
      //       SizedBox(
      //         height: 8,
      //       ),
      //       Text(
      //         '${widget.book.description}',
      //       ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       bolderTextStyle('Content', fontSize: 16.0),
      //       SizedBox(
      //         height: 5,
      //       ),
      //       // Text(
      //       //   '${widget.book.contents}',
      //       // ),
      //       PageView(
      //         controller: _pageController,
      //         children: [
      //           Text('First Page'),
      //           Text('Second Page'),
      //           Text('Third Page'),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    // offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(4),
              child: CircleAvatar(
                child: Icon(
                  Icons.pause,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    // offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.headset,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  // SizedBox(width: 10,),
                  CircleAvatar(
                    child: Icon(
                      Icons.format_align_right,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.teal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
