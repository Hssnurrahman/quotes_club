import 'package:flutter/material.dart';
import 'package:quotes_app/models/whats_new.dart';

import 'package:quotes_app/widgets/app_bar.dart';

class WhatsNewScreen extends StatelessWidget {
  static const routeName = "/whats-new-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "What's New",
        true,
        FlatButton(onPressed: null, child: null),
      ),
      body: WhatsNew(),
    );
  }
}
