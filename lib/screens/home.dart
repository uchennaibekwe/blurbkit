import 'dart:convert';

import 'package:blurbkit/models/book.dart';
import 'package:blurbkit/models/bookmark.dart';
import 'package:blurbkit/models/result.dart';
import 'package:blurbkit/services/book.services.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:blurbkit/widgets/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<bool> bookmark = new List(19);
  final bookmark = List<bool>.generate(3, (i) => false);
  final bookApi = BookApi();
  var bookmarks = {};
  // var bookmarksId = {};
  // List<Bookmark> bookmarksList = [];
  Future books;
  Future randomBooks;
  // List books;

  void initState() {
    super.initState();
    // print('welcome');
    books = bookApi.getBooks();
    randomBooks = bookApi.getRandomBooks();

    bookApi.getBookMarks().then((res) {
      print(res);
      if (res.statusCode == 200) {
        var bookmarksList =
            Result.fromJsonBookmark(json.decode(res.body)).bookmarks;
        for (Bookmark bookmark in bookmarksList) {
          // bookmarks.add(bookmark.book);
          bookmarks[bookmark.id] = bookmark.book;
        }
        print(bookmarks);
      }
      print(bookmarks);
    }).catchError((onError) {
      errorNotification('$onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  bolderTextStyle('For you', fontSize: 20.0),
                  bolderTextStyle('more ...', fontSize: 15.0),
                ],
              ),
              boldTextStyle('Recomendations'),
              FutureBuilder(
                  future: books,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // if (snapshot.data == 401) {
                      //   Navigator.pushNamed(context, '/login');
                      // }

                      var books =
                          Result.fromJson(json.decode(snapshot.data.body))
                              .books;
                      return SizedBox(
                        height: 295,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          itemBuilder: (BuildContext context, i) => Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 5,
                                  child: Image(
                                    image:
                                        NetworkImage('${books[i].thumbnail}'),
                                    // image:
                                    //     AssetImage('images/books/the_book_title.jpg'),
                                    height: 230,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/bookdescription',
                                      arguments: books[i]);
                                },
                              ),
                              Card(
                                child: Container(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  '${books[i].author ?? 'Anonymous'}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                '${books[i].title}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // boldTextStyle('${books[i].author}', fontSize: 12.0),
                                              // bolderTextStyle('${books[i].title}'),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 24,
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                              child: 2 ==
                                                      2 // book has been bookemarkd
                                                  ? Icon(
                                                      Icons.bookmark,
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons.bookmark_border,
                                                      size: 30,
                                                    ),
                                              onTap: () {
                                                print(books[i].id);
                                                setState(() {
                                                  if (bookmarks.containsValue(
                                                      '7b67e9f9-3682-47f3-9f3f-d2da2a50854f')) {
                                                    // bookmark exist
                                                    // remove from bookmark list
                                                    // TODO: remove from remote server
                                                    bookmarks.removeWhere((key,
                                                            value) =>
                                                        value == books[i].id);
                                                    // bookApi
                                                    //     .removeBookmark(
                                                    //         books[i].id)
                                                    //     .then((value) {
                                                    //   toastMessage(
                                                    //       'Bookmark Successful!');
                                                    // }).catchError((onError) {
                                                    //   errorNotification(
                                                    //     '$onError',
                                                    //   );
                                                    //   bookmarks
                                                    //       .remove(books[i].id);
                                                    // });
                                                  } else {
                                                    bookmarks['newId'] =
                                                        books[i].id;
                                                    // bookApi
                                                    //     .createBookmark(
                                                    //         books[i].id)
                                                    //     .then((value) {
                                                    //   toastMessage(
                                                    //       'Bookmark Successful!');
                                                    // }).catchError((onError) {
                                                    //   errorNotification(
                                                    //     '$onError',
                                                    //   );
                                                    //   bookmarks
                                                    //       .remove(books[i].id);
                                                    // });
                                                  }
                                                  // print(bookmarks);
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return linearProgressIndicator();
                    }
                  }),
              // SizedBox(
              //   height: 295,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: books.length,
              //     itemBuilder: (BuildContext context, i) => Column(
              //       children: <Widget>[
              //         GestureDetector(
              //           child: Card(
              //             clipBehavior: Clip.hardEdge,
              //             elevation: 5,
              //             child: Image(
              //               image:
              //                   NetworkImage('${books[i].thumbnail}'),
              //               // image:
              //               //     AssetImage('images/books/the_book_title.jpg'),
              //               height: 230,
              //               width: 150,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           onTap: () {
              //             Navigator.pushNamed(context, '/bookdescription', arguments: books[i]);
              //           },
              //         ),
              //         Card(
              //           child: Container(
              //             width: 150,
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: <Widget>[
              //                   Expanded(
              //                     flex: 10,
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: <Widget>[
              //                         Text('${books[i].author ?? 'Anonymous'}', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500)),
              //                         Text('${books[i].title}', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
              //                         // boldTextStyle('${books[i].author}', fontSize: 12.0),
              //                         // bolderTextStyle('${books[i].title}'),
              //                       ],
              //                     ),
              //                   ),
              //                   // SizedBox(
              //                   //   width: 24,
              //                   // ),
              //                   Expanded(
              //                     flex: 2,
              //                     child: GestureDetector(
              //                         child: bookmark[i] == false
              //                             ? Icon(
              //                                 Icons.bookmark_border,
              //                                 size: 30,
              //                               )
              //                             : Icon(
              //                                 Icons.bookmark,
              //                                 size: 30,
              //                               ),
              //                         onTap: () {
              //                           setState(() {
              //                             bookmark[i] = !bookmark[i];
              //                           });
              //                         }),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  bolderTextStyle('What others are reading', fontSize: 22.0),
                  bolderTextStyle('more ...', fontSize: 15.0),
                ],
              ),
              boldTextStyle('Trending'),
              FutureBuilder(
                  future: randomBooks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      var books =
                          Result.fromJson(json.decode(snapshot.data.body))
                              .books;
                      return SizedBox(
                        height: 295,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          itemBuilder: (BuildContext context, i) => Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 5,
                                  child: Image(
                                    image:
                                        NetworkImage('${books[i].thumbnail}'),
                                    // image:
                                    //     AssetImage('images/books/the_book_title.jpg'),
                                    height: 230,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/bookdescription',
                                      arguments: books[i]);
                                },
                              ),
                              Card(
                                child: Container(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  '${books[i].author ?? 'Anonymous'}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                '${books[i].title}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // boldTextStyle('${books[i].author}', fontSize: 12.0),
                                              // bolderTextStyle('${books[i].title}'),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 24,
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                              child: bookmark[i] == false
                                                  ? Icon(
                                                      Icons.bookmark_border,
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons.bookmark,
                                                      size: 30,
                                                    ),
                                              onTap: () {
                                                setState(() {
                                                  bookmark[i] = !bookmark[i];
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return linearProgressIndicator();
                    }
                  }),
              // SizedBox(
              //   height: 295,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: bookmark.length,
              //       itemBuilder: (BuildContext context, i) => Column(
              //             children: <Widget>[
              //               Card(
              //                 clipBehavior: Clip.hardEdge,
              //                 elevation: 5,
              //                 child: Image(
              //                   image: AssetImage('images/books/300.jpg'),
              //                   height: 230,
              //                 ),
              //               ),
              //               Card(
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     children: <Widget>[
              //                       Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: <Widget>[
              //                           boldTextStyle('Actor Name',
              //                               fontSize: 12.0),
              //                           bolderTextStyle('The Outlier'),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 20,
              //                       ),
              //                       GestureDetector(
              //                           child: bookmark[i] == false
              //                               ? Icon(
              //                                   Icons.bookmark_border,
              //                                   size: 30,
              //                                 )
              //                               : Icon(
              //                                   Icons.bookmark,
              //                                   size: 30,
              //                                 ),
              //                           onTap: () {
              //                             setState(() {
              //                               bookmark[i] = !bookmark[i];
              //                             });
              //                           }),
              //                     ],
              //                   ),
              //                 ),
              //               )
              //             ],
              //           )),
              // ),

              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  bolderTextStyle('Curated Reading List', fontSize: 20.0),
                  bolderTextStyle('more ...', fontSize: 15.0),
                ],
              ),
              boldTextStyle('What Africa Leaders are reading'),
              SizedBox(
                height: 295,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: bookmark.length,
                    itemBuilder: (BuildContext context, i) => Column(
                          children: <Widget>[
                            Card(
                              clipBehavior: Clip.hardEdge,
                              elevation: 5,
                              child: Image(
                                image:
                                    AssetImage('images/books/the-arsonist.jpg'),
                                height: 230,
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        boldTextStyle('Actor Name',
                                            fontSize: 12.0),
                                        bolderTextStyle('The Outlier'),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    GestureDetector(
                                        child: bookmark[i] == false
                                            ? Icon(
                                                Icons.bookmark_border,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.bookmark,
                                                size: 30,
                                              ),
                                        onTap: () {
                                          setState(() {
                                            bookmark[i] = !bookmark[i];
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
