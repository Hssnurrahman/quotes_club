import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:quotes_app/widgets/quote_card.dart';

enum SelectOptions {
  Like,
  Dislike,
  Share,
  Delete,
}

class QuotesScreen extends StatefulWidget {
  static const routeName = "/quotes-screen";

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaginateFirestore(
          onEmpty: Text(
            "No Quotes Found, Start By Adding One!",
            style: TextStyle(
              fontFamily: "Ubuntu",
              fontSize: 15,
            ),
          ),
          bottomLoader: BottomLoader(),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilderType: PaginateBuilderType.listView,
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
              .limit(itemsPerPage),
          itemsPerPage: itemsPerPage,
        ),
      ],
    );
  }
}
