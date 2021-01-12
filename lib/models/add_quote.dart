import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app/screens/tabs_screen.dart';
import 'package:quotes_app/widgets/app_bar.dart';
import 'package:quotes_app/widgets/sized_box.dart';


class AddQuote extends StatefulWidget {
  static const routeName = "/add-quote";

  @override
  _AddQuoteState createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {



  var _quote = "";
  var _authorName = "";

  List<String> _categories = [
    "Life",
    "Love",
    "Time",
    "Nature",
    "Special Days",
    "Islamic",
    "Urdu",
    "Others",
  ];
  String _selectedCategory;

  List<String> _languages = [
    "English",
    "Urdu",
    "Hindi",
    "Arabic",
    "Chinese",
  ];
  String _selectedLanguage = "English";

  bool _isAdding = false;

  final _addQuoteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: QuotesAppBar().appBar(
        "Add Quote",
        false,
        FlatButton(onPressed: null, child: null),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(
            10,
          ),
          child: Form(
            key: _addQuoteFormKey,
            child: Column(
              children: <Widget>[
                QuoteSizedBox().addQuoteSizedBox(
                  15,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                    fontSize: 16,
                  ),
                  minLines: 1,
                  maxLines: 5,
                  key: ValueKey(
                    "quote",
                  ),
                  cursorColor: Colors.blue[100],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[700],
                    hintText: "Enter Quote",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Ubuntu",
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (quote) {
                    _quote = quote;
                  },
                ),
                QuoteSizedBox().addQuoteSizedBox(
                  15,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                    fontSize: 16,
                  ),
                  minLines: 1,
                  // maxLines: maxLines,
                  key: ValueKey(
                    "authorName",
                  ),
                  cursorColor: Colors.blue[100],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[700],
                    hintText: "Enter Author Name (If You Know)",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Ubuntu",
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (authorName) {
                    _authorName = authorName;
                  },
                ),
                QuoteSizedBox().addQuoteSizedBox(
                  15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Category: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontSize: 17,
                      ),
                    ),
                    DropdownButton(
                      dropdownColor: Colors.grey[300],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontSize: 16,
                      ),
                      hint: Text(
                        "Select Category",
                      ),
                      // Not necessary for Option 1
                      value: _selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: _categories.map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Ubuntu",
                              fontSize: 16,
                            ),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                QuoteSizedBox().addQuoteSizedBox(
                  15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Language: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontSize: 17,
                      ),
                    ),
                    DropdownButton(
                      dropdownColor: Colors.grey[300],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontSize: 16,
                      ),
                      hint: Text(
                        "English (Default)",
                      ),
                      // Not necessary for Option 1
                      value: _selectedLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                      },
                      items: _languages.map((language) {
                        return DropdownMenuItem(
                          child: new Text(
                            language,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Ubuntu",
                              fontSize: 16,
                            ),
                          ),
                          value: language,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                QuoteSizedBox().addQuoteSizedBox(
                  20,
                ),
                if (_isAdding) CircularProgressIndicator(),
                if (!_isAdding)
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      elevation: 5,
                      color: Colors.teal,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () async {
                        if (_authorName.length == 0) {
                          _authorName = "Unknown";
                        }

                        print(
                          "Selected Language: $_selectedLanguage",
                        );

                        _addQuoteFormKey.currentState.save();

                        setState(() {
                          _isAdding = true;
                        });

                        if (_selectedCategory == null) {
                          showToast(
                            "Please Select Any Category!",
                          );

                          setState(() {
                            _isAdding = false;
                          });

                          return;
                        }

                        if (_quote.length == 0) {
                          showToast(
                            "Please Enter Quote To Add!",
                          );

                          setState(() {
                            _isAdding = false;
                          });

                          return;
                        }

                        final user = FirebaseAuth.instance.currentUser;

                        final userData = await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user.uid)
                            .get();

                        await FirebaseFirestore.instance
                            .collection("quotes")
                            .add(
                          {
                            "quote": _quote,
                            "authorName": _authorName.length == 0
                                ? "Unknown"
                                : _authorName,
                            "creatorName": userData["userName"],
                            "creatorId": user.uid,
                            "createdAt": Timestamp.now(),
                            "category": _selectedCategory,
                            "language": _selectedLanguage,
                            "isDelete": false,
                            "isEdited": false,
                          },
                        );

                        showToast(
                          "Quote Added!",
                        );

                        Navigator.of(context).pushReplacementNamed(
                          TabsScreen.routeName,
                        );

                        setState(() {
                          _isAdding = false;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
