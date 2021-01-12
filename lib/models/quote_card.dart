import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:quotes_app/widgets/quote_card.dart';
import 'package:share/share.dart';

import 'quotes.dart';

enum SelectOptions {
  Like,
  Dislike,
  Share,
  Delete,
}

// ignore: must_be_ime
class QuoteCard extends StatefulWidget {
  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  List<DocumentSnapshot> _quotes = [];
  bool _loadingQuotes = false;
  DocumentSnapshot _lastDocument;
  bool _gettingMoreQuotes = false;
  bool _moreQuotesAvailable = true;
  int itemsPerPage = 6;

  _getQuotes() async {
    var query = FirebaseFirestore.instance
        .collection("quotes")
        .limit(itemsPerPage)
        .orderBy(
          "createdAt",
          descending: true,
        );

    if (mounted)
      setState(() {
        _loadingQuotes = true;
      });

    QuerySnapshot quoteSnapshot = await query.get();

    if (quoteSnapshot.docs.length < itemsPerPage) {
      _moreQuotesAvailable = false;
    }

    _quotes = quoteSnapshot.docs;

    _lastDocument = quoteSnapshot.docs[quoteSnapshot.docs.length - 1];

    if (mounted)
      setState(() {
        _loadingQuotes = false;
      });
  }

  _getMoreQuotes() async {
    setState(() {
      _gettingMoreQuotes = true;
    });

    var query = FirebaseFirestore.instance
        .collection("quotes")
        .limit(itemsPerPage)
        .orderBy(
          "createdAt",
          descending: true,
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

    setState(() {
      _gettingMoreQuotes = false;
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getQuotes();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return !_loadingQuotes
        ? Column(
            children: <Widget>[
              Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final createdDate = _quotes[index].data()["createdAt"];

                    final String language = _quotes[index].data()["language"];

                    // print("Language: $language",);

                    return QuotesCard().quoteCard(
                      context,
                      _quotes,
                      index,
                      createdDate,
                        _quotes[index].data()["language"],
                    );
                  },
                  itemCount: _quotes?.length,
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
                        _getMoreQuotes();
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
            ],
          )
        : Center(
          child: CircularProgressIndicator(),
        );
  }
}

class SearchByQuote extends SearchDelegate<Quotes> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.cancel,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(
            context,
            null,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final quoteData = Provider.of<Quotes>(context).quotes;

    final quoteList = query.isEmpty
        ? quoteData
        : quoteData
            .where(
              (p) => p.quote.contains(
                query,
              ),
            )
            .toList();

    return quoteList.isEmpty
        ? Center(
            child: Text(
              "No Results Found",
              style: TextStyle(fontSize: 20, color: Colors.deepOrange),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final quotesList = quoteList[index];

              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
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
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).appBarTheme.color,
                          child: Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          radius: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          quotesList.quote,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          color: Theme.of(context).dividerTheme.color,
                          thickness: Theme.of(context).dividerTheme.thickness,
                          indent: Theme.of(context).dividerTheme.indent,
                          endIndent: Theme.of(context).dividerTheme.endIndent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date : ${DateFormat.yMMMd().format(DateTime.now())}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Time : ${DateFormat.jm().format(DateTime.now())}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Added By : ${quotesList.addedBy}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Author : ${quotesList.authorName}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: quoteList.length,
          );
  }
}

class SearchByAuthor extends SearchDelegate<Quotes> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.cancel,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(
            context,
            null,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final quoteData = Provider.of<Quotes>(context).quotes;

    final quoteList = query.isEmpty
        ? quoteData
        : quoteData
            .where(
              (p) => p.authorName.toLowerCase().startsWith(
                    query,
                  ),
            )
            .toList();

    return quoteList.isEmpty
        ? Center(
            child: Text(
              "No Results Found",
              style: TextStyle(fontSize: 20, color: Colors.deepOrange),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final quotesList = quoteList[index];

              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
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
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).appBarTheme.color,
                          child: Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          radius: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          quotesList.quote,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          color: Theme.of(context).dividerTheme.color,
                          thickness: Theme.of(context).dividerTheme.thickness,
                          indent: Theme.of(context).dividerTheme.indent,
                          endIndent: Theme.of(context).dividerTheme.endIndent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date : ${DateFormat.yMMMd().format(DateTime.now())}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Time : ${DateFormat.jm().format(DateTime.now())}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Added By : ${quotesList.addedBy}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Author : ${quotesList.authorName}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: quoteList.length,
          );
  }
}
