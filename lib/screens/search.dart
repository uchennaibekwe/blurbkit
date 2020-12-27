import 'dart:convert';

import 'package:blurbkit/models/category.dart';
import 'package:blurbkit/models/result.dart';
import 'package:blurbkit/services/book.services.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:blurbkit/widgets/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List categoryList = <Category>[];
  List displayList = <Widget>[];
  final bookApi = BookApi();
  Future categories;

  void initState() {
    super.initState();
    categories = bookApi.getBookCategories();
    // bookApi.getBooks().then((res) {
    //   print(res);
    //   if (res.statusCode == 200) {
    //     categories = Result.fromJson(json.decode(res.body)).categories;
    //     print(res.body);
    //   } else {
    //     errorNotification('Error ${res.statusCode} occurred!');
    //   }
    //   print(res);
    // }).catchError((onError) {
    //   errorNotification('$onError');
    // });
  }

  searchField<Widget>({String fieldName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        // elevation: 3,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
          enableSuggestions: true,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
            fontSize: 17,
            // fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: fieldName,
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) return 'This field is required!';

            return null;
          },
          onChanged: (val) {
            // successNotification(val);
            if (val.isEmpty) return false;
            // search for book category

            setState(() {
              displayList.clear();
              displayList.insert(0, searchingCategory());
              displayList.insert(0, searchingCategory());
            });

            // displayList
            bookApi.getBookCategories(searchTerm: val).then((res) {
              if (res.statusCode == 200) {
                categoryList =
                    Result.fromJsonCategories(json.decode(res.body)).categories;
                // print('Category List: $categoryList');
                setState(() {
                  displayList.clear();
                });

                for (Category category in categoryList) {
                  setState(() {
                    displayList.add(
                      searchCategory(
                        label: '${category.title}',
                        imageLink: '${category.thumbnail}',
                      ),
                    );
                  });
                }

                print('done searching');
              } else {
                errorNotification('Error ${res.statusCode} occurred!');
              }
            }).catchError((onError) {
              // remove the two linearProgressIndicator() adding initially
              displayList.removeRange(0, 1);
              errorNotification('$onError');
            });
          },
          onSaved: (val) => setState(() {}),
        ),
      ),
    );
  }

  searchCategory({String label, String imageLink}) => Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
                child: Image(
                    image: NetworkImage('$imageLink'),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover)
                // child: Icon(
                //   icon,
                //   color: appSecondaryColor(),
                //   size: 30,
                // ),
                ),
            color: Colors.white,
          ),
        ),
      ),
      bolderTextStyle('$label'),
    ],
  );

  searchingCategory() => Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
                child: Icon(
                  Icons.find_in_page,
                  color: appSecondaryColor(),
                  size: 30,
                ),
                ),
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
        child: LinearProgressIndicator(
          minHeight: 2,
          backgroundColor: appColor(),
          valueColor: AlwaysStoppedAnimation<Color>(appSecondaryColor()),
        ),
      ),
    ],
  );

  searchCategoryCard({String label, IconData icon}) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: appSecondaryColor(),
                    size: 50,
                  ),
                ),
                color: Colors.white,
              ),
            ),
          ),
          bolderTextStyle('$label'),
        ],
      );
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // extendBodyBehindAppBar: true,
    return Column(
      children: <Widget>[
        SizedBox(
          height: 23,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appColor(), Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 150, 136, 0.2), spreadRadius: 5),
            ],
          ),
          child: searchField(fieldName: 'Search Categories'),
        ),
        FutureBuilder(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                errorNotification('${snapshot.error}');
                // return Container();
              }

              if (snapshot.hasData) {
                if (snapshot.data.statusCode == 200) {
                  // print(snapshot.data.body);
                  categoryList =
                      Result.fromJsonCategories(json.decode(snapshot.data.body))
                          .categories;
                  // print('Category List: $categoryList');
                  for (Category category in categoryList)
                    displayList.add(
                      searchCategory(
                        label: '${category.title}',
                        imageLink: '${category.thumbnail}',
                      ),
                    );

                  return Expanded(
                    child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 30),
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 2,
                        children: <Widget>[] + displayList
                        // children: <Widget>[
                        //   for (Category category in categoryList)
                        //     searchCategoryCard(
                        //         label: '${category.title}',
                        //         icon: Icons.nature_people),
                        //   // searchCategoryCard(
                        //   //     label: 'Personal Development',
                        //   //     icon: Icons.nature_people),
                        //   // searchCategoryCard(
                        //   //     label: 'Entrepreneurship', icon: Icons.work),
                        //   // searchCategoryCard(
                        //   //     label: 'Personal Dev', icon: Icons.people),
                        //   // searchCategoryCard(
                        //   //     label: 'Tech & Future of Work',
                        //   //     icon: Icons.computer),
                        //   // searchCategoryCard(
                        //   //     label: 'Business Development',
                        //   //     icon: Icons.attach_money),
                        //   // searchCategoryCard(
                        //   //     label: 'Leadership',
                        //   //     icon: Icons.indeterminate_check_box),
                        //   // searchCategoryCard(
                        //   //     label: 'Communication', icon: Icons.phone_in_talk),
                        //   // searchCategoryCard(
                        //   //     label: 'Career Development',
                        //   //     icon: Icons.person_add),
                        //   FlatButton(
                        //       onPressed: () {
                        //         print('Adding');
                        //         setState(() {
                        //           categoryList.add(Category(
                        //               title: 'career5',
                        //               description: 'New Item7'));
                        //           categoryList = categoryList;
                        //         });
                        //         print(categoryList);
                        //       },
                        //       child: Text('Load More')),
                        // ],
                        ),
                  );
                } else {
                  // error
                  // statusCode is not 200
                  return Center(child: Text('${snapshot.data.statusCode}'));
                }
              } else {
                // return pageLoader();
                return Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 2,
                    children: <Widget>[
                    //   linearProgressIndicator(),
                    //   linearProgressIndicator(),
                      searchingCategory(),
                      searchingCategory(),
                      searchingCategory(),
                      searchingCategory(),
                      searchingCategory(),
                      searchingCategory(),
                    ],
                  ),
                );
              }
            }),
        Container(
          child: FlatButton(
            onPressed: () {
              setState(() {
                displayList.clear();
              });
              print(displayList.length);
              // print('Adding');
              // setState(() {
              //   displayList.add(
              //     searchCategoryCard(
              //       label: 'New Item',
              //       icon: Icons.nature_people,
              //     ),
              //   );
              // });
              // print(displayList);
            },
            child: Text('Load More'),
          ),
        )
      ],
    );
    // );
  }
}
