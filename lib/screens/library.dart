import 'dart:convert';

import 'package:blurbkit/models/bookmark.dart';
import 'package:blurbkit/services/book.services.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Future bookmarks;
  final bookApi = BookApi();

  void initState() {
    super.initState();

    // bookmarks = bookApi.getUserBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            bolderTextStyle('LIBRARY', fontSize: 16.0),
            SizedBox(
              height: 10,
            ),
            Expanded(
              // height: double.maxFinite,
              child: Container(
                // margin:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, i) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Image(
                                image: AssetImage('images/books/300.jpg'),
                                width: 80,
                                height: 85,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'The Outliers',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Hames Wattford',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Lorem Ipsom la ipsom de lorem',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.bookmark),
                            ),
                          ],
                        ),
                        i < 9
                            ? Divider(
                                thickness: 1,
                              )
                            : Container(),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
