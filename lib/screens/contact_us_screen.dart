import 'package:flutter/material.dart';
import 'package:quotes_app/models/contact_us.dart';
import 'package:quotes_app/widgets/app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = "/contact-us-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuotesAppBar().appBar(
        "Contact Us",
        true,
      ),
      body: ContactUs(),
    );
  }
}
