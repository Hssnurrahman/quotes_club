import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:paginate_firestore/widgets/initial_loader.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/quote_card.dart';

class CreatorQuotesScreen extends StatelessWidget {
  static const routeName = "/creator-quote-screen";

  final String? creatorName;

  const CreatorQuotesScreen({
    Key? key,
    this.creatorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemsPerPage = 10;

    return Scaffold(
      appBar: QuotesAppBar().appBar(
        creatorName!,
        true,
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
              PaginateFirestore(
                onEmpty: Text(
                  "No Quotes Found, Start By Adding One!",
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 15,
                  ),
                ),
                initialLoader: InitialLoader(),
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
                    .where(
                      "creatorName",
                      isEqualTo: creatorName,
                    ),
                itemsPerPage: itemsPerPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
