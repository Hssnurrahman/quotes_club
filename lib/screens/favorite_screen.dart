import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<DocumentSnapshot> _quotes = [];
  bool _loadingQuotes = false;
  DocumentSnapshot _lastDocument;
  bool _gettingMoreQuotes = false;
  bool _moreQuotesAvailable = true;
  int itemsPerPage = 6;

  _getQuotes() async {
    var query = FirebaseFirestore.instance
        .collection("quotes")
        .where(
          "isFavorite",
          isEqualTo: true,
        )
        .limit(itemsPerPage)
        .orderBy(
          "createdAt",
          descending: true,
        );

    setState(() {
      _loadingQuotes = true;
    });

    QuerySnapshot quoteSnapshot = await query.get();

    if (quoteSnapshot.docs.length < itemsPerPage) {
      _moreQuotesAvailable = false;
    }

    _quotes = quoteSnapshot.docs;

    _lastDocument = quoteSnapshot.docs[quoteSnapshot.docs.length - 1];

    setState(() {
      _loadingQuotes = false;
    });
  }

  _getMoreQuotes() async {
    var query = FirebaseFirestore.instance
        .collection("quotes")
        .limit(itemsPerPage)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .where(
          "isFavorite",
          isEqualTo: true,
        )
        .startAfter([_lastDocument.data()["createdAt"]]);

    QuerySnapshot quoteSnapshot = await query.get();

    _lastDocument = quoteSnapshot.docs[quoteSnapshot.docs.length - 1];

    if (quoteSnapshot.docs.length < itemsPerPage) {
      _moreQuotesAvailable = false;
    }

    _lastDocument = quoteSnapshot.docs[quoteSnapshot.docs.length - 1];

    _quotes.addAll(
      quoteSnapshot.docs,
    );

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    // void likeCounter(index) {
    //   setState(() {
    //     favData[index].likes = favData[index].likes + 1;
    //   });
    // }
    //
    // void dislikeCounter(index) {
    //   setState(() {
    //     favData[index].dislikes = favData[index].dislikes + 1;
    //   });
    // }

//     void shareCounter(index, context) {
//       setState(() {
//         favData[index].shares = favData[index].shares + 1;
//       });
//
// //      final RenderBox box = context.FindRenderBox();
//       final String text = """${favData[index].quote}
//
//     ${favData[index].authorName}
//       """;
//
//       Share.share(
//         text,
//         subject: favData[index].quote,
// //        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//       );
//     }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Quotes",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Sansita Swashed Regular",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final user = FirebaseAuth.instance.currentUser.uid;

                    final isMineFavorite =
                        user == _quotes[index].data()["quote"];

                    print(
                      isMineFavorite,
                    );

                    return Container(
                      // height: MediaQuery.of(context).size.width * 0.65,
                      child: InkWell(
                        onDoubleTap: () async {
                          final user = FirebaseAuth.instance.currentUser;

                          FirebaseFirestore.instance
                              .collection("quotes")
                              .doc(_quotes[index].id)
                              .update(
                            {
                              "isFavorite": true,
                              "favoriteId": user.uid,
                            },
                          );

                          Fluttertoast.showToast(
                            msg: "Quote Added To Favorites",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.black.withOpacity(
                              0.7,
                            ),
                            textColor: Colors.white,
                            gravity: ToastGravity.BOTTOM,
                          );
                        },
                        onLongPress: () {
                          FlutterClipboard.copy(
                            _quotes[index]["quote"],
                          );

                          Fluttertoast.showToast(
                            msg: "Quote Copied!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[700].withOpacity(
                              0.7,
                            ),
                            textColor: Colors.white,
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                15,
                              ),
                              topRight: Radius.circular(
                                15,
                              ),
                            ),
                          ),
                          margin: Theme.of(context).cardTheme.margin,
                          elevation: Theme.of(context).cardTheme.elevation,
                          color: Theme.of(context).cardTheme.color,
                          child: Container(
                            margin: EdgeInsets.all(
                              10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_quotes[index].data()["creatorName"]}",
                                  style: TextStyle(
                                    fontFamily: "A Anti Corona",
                                    fontSize: 15,
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      _quotes[index].data()["quote"],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 21,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Author: ${_quotes[index].data()["authorName"]}",
                                      style: TextStyle(
                                        fontFamily: "A Anti Corona",
                                        fontSize: 14,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Time: ${DateFormat.jm().format(_quotes[index].data()["createdAt"].toDate())}",
                                      style: TextStyle(
                                        fontFamily: "A Anti Corona",
                                        fontSize: 14,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 14,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Copy",
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 14,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Favorite",
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 14,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _quotes.length,
                ),
              ),
            ),
            _moreQuotesAvailable && _quotes.length != 0
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    onPressed: () {
                      if (_moreQuotesAvailable && _quotes.length % 6 == 0) {
                        _moreQuotesAvailable = false;
                      }

                      _getMoreQuotes();

                      print(
                        "Load More Quotes",
                      );
                    },
                    child: Text(
                      "Load More",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Ubuntu",
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),

            // PaginateFirestore(
            //   initialLoader: Center(
            //     child: CircularProgressIndicator(),
            //   ),
            //   emptyDisplay: Center(
            //     child: Text(
            //       "No Quotes Added Yet! Start By Adding One",
            //     ),
            //   ),
            //   itemsPerPage: 1,
            //   physics: ScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilderType: PaginateBuilderType.listView,
            //   itemBuilder: (index, context, quoteSnapshot) {
            //     final user = FirebaseAuth.instance.currentUser;
            //
            //     final isMineFavorite =
            //         user.uid == quoteSnapshot.data()["favoriteId"];
            //
            //     return isMineFavorite
            //         ? Container(
            //             // height: MediaQuery.of(context).size.width * 0.65,
            //             child: InkWell(
            //               onDoubleTap: () async {
            //                 final user = FirebaseAuth.instance.currentUser;
            //                 final userData = await FirebaseFirestore.instance
            //                     .collection(
            //                       "users",
            //                     )
            //                     .doc(
            //                       user.uid,
            //                     )
            //                     .get();
            //
            //                 FirebaseFirestore.instance
            //                     .collection("quotes")
            //                     .doc(quoteSnapshot.id)
            //                     .update(
            //                   {
            //                     "isFavorite": true,
            //                     "favoriteId": user.uid,
            //                   },
            //                 );
            //               },
            //               child: Card(
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(
            //                     10,
            //                   ),
            //                 ),
            //                 margin: Theme.of(context).cardTheme.margin,
            //                 elevation: Theme.of(context).cardTheme.elevation,
            //                 color: Theme.of(context).cardTheme.color,
            //                 child: Container(
            //                   margin: EdgeInsets.all(
            //                     10,
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         quoteSnapshot.data()["quote"],
            //                         textAlign: TextAlign.justify,
            //                         style: Theme.of(context).textTheme.subtitle1,
            //                       ),
            //                       SizedBox(
            //                         height: 7,
            //                       ),
            //                       Divider(
            //                         color: Theme.of(context).dividerTheme.color,
            //                         thickness:
            //                             Theme.of(context).dividerTheme.thickness,
            //                         indent: Theme.of(context).dividerTheme.indent,
            //                         endIndent:
            //                             Theme.of(context).dividerTheme.endIndent,
            //                       ),
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceAround,
            //                         children: [
            //                           Text(
            //                             "Date : ${DateFormat.yMMMd().format(quoteSnapshot.data()["createdAt"].toDate())}",
            //                             style:
            //                                 Theme.of(context).textTheme.subtitle1,
            //                           ),
            //                           Text(
            //                             "Time : ${DateFormat.jm().format(quoteSnapshot.data()["createdAt"].toDate())}",
            //                             style:
            //                                 Theme.of(context).textTheme.subtitle1,
            //                           ),
            //                         ],
            //                       ),
            //                       SizedBox(
            //                         height: 6,
            //                       ),
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceAround,
            //                         children: [
            //                           Text(
            //                             "Added By : ${quoteSnapshot.data()["creatorName"]}",
            //                             style:
            //                                 Theme.of(context).textTheme.subtitle1,
            //                           ),
            //                           Text(
            //                             "Author : ${quoteSnapshot.data()["authorName"]}",
            //                             style:
            //                                 Theme.of(context).textTheme.subtitle1,
            //                           ),
            //                         ],
            //                       ),
            //
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           )
            //         : Container();
            //   },
            //   // orderBy is compulsary to enable pagination
            //   query: FirebaseFirestore.instance
            //       .collection('quotes')
            //       .where(
            //         "isFavorite",
            //         isEqualTo: true,
            //       )
            //       // .where(
            //       //   "creatorName",
            //       //   isNotEqualTo: "Hassan Ur Rahman",
            //       // )
            //       .orderBy('quote'),
            // ),
          ],
        ),
      ),
    );
  }
}
