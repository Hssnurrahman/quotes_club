import 'package:flutter/material.dart';

class Quote with ChangeNotifier {
  final String? addedBy;
  final String? quote;
  final String? authorName;
  final String? date;
  final String? time;
  int? likes;
  int? dislikes;
  int? shares;
  bool? favorite;

  Quote({
    this.addedBy,
    this.quote,
    this.authorName,
    this.date,
    this.time,
    this.likes,
    this.dislikes,
    this.shares,
    this.favorite,
  });
}
