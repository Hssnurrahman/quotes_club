import 'package:flutter/material.dart';

class QuoteDivider {
  Divider settingsDivider(BuildContext context) {
    return Divider(
      indent: MediaQuery.of(context).size.width * 0.05,
      endIndent: MediaQuery.of(context).size.width * 0.04,
      color: Colors.grey[700],
    );
  }

  Divider quotesDivider() {
    return Divider(
      color: Colors.grey[300],
    );
  }

  Divider userGuideDivider() {
    return Divider(
      color: Colors.grey[700],
    );
  }
}
