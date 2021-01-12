import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/quote_card.dart';
import 'package:share/share.dart';

class MyQuotesScreen extends StatefulWidget {
  @override
  _MyQuotesScreenState createState() => _MyQuotesScreenState();
}

class _MyQuotesScreenState extends State<MyQuotesScreen> {
  List<DocumentSnapshot> _quotes = [];
  bool _loadingQuotes = false;
  DocumentSnapshot _lastDocument;
  bool _gettingMoreQuotes = false;
  bool _moreQuotesAvailable = true;
  int itemsPerPage = 6;
  final _userId = FirebaseAuth.instance.currentUser.uid;

  _getQuotes() async {
    var query = FirebaseFirestore.instance
        .collection("quotes")
        .limit(itemsPerPage)
        .where(
          "creatorId",
          isEqualTo: _userId,
        )
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
          "creatorId",
          isEqualTo: _userId,
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
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "My Quotes",
        false,
        FlatButton(onPressed: null, child: null),
      ),
      body: Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final createdDate = _quotes[index].data()["createdAt"];

                    final language = _quotes[index].data()["language"];


                    return QuotesCard().quoteCard(
                      context,
                      _quotes,
                      index,
                      createdDate,
                        _quotes[index].data()["language"]
                    );
                  },
                  itemCount: _quotes.length,
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
            ],
          ),
        ),
      ),
    );
  }
}
