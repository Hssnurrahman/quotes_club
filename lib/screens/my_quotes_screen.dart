import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/quote_card.dart';

class MyQuotesScreen extends StatefulWidget {
  @override
  _MyQuotesScreenState createState() => _MyQuotesScreenState();
}

class _MyQuotesScreenState extends State<MyQuotesScreen> {
  int itemsPerPage = 10;
  final _userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: QuotesAppBar().appBar(
        "My Quotes",
        false,
      ),
      body: Container(
        padding: EdgeInsets.all(
          10,
        ),
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              FirestorePagination(
                limit: itemsPerPage,
                onEmpty: Text(
                  "No Quotes Found, Start By Adding One!",
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 15,
                  ),
                ),
                bottomLoader: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.blue,
                  ),
                ),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                viewType: ViewType.list,
                itemBuilder: (context, documentSnapshots, index) {
                  final data = documentSnapshots[index].data() as Map;

                  final createdDate = data["createdAt"];

                  final language = data["language"];

                  final quote = data["quote"];

                  final creatorName = data["creatorName"];

                  final authorName = data["authorName"];

                  return QuotesCard(
                    quote: quote,
                    createdDate: createdDate,
                    authorName: authorName,
                    creatorName: creatorName,
                    language: language,
                  );
                },
                query: FirebaseFirestore.instance
                    .collection("quotes")
                    .orderBy(
                      "createdAt",
                      descending: true,
                    )
                    .where(
                      "creatorId",
                      isEqualTo: _userId,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
