import 'package:flutter/material.dart';

class QuoteTextField {
  TextFormField quoteTextField(
    String valueKey,
    String hintText,
    String text,
    int minLines,
    int maxLines,
  ) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Ubuntu",
        fontSize: 16,
      ),
      minLines: minLines,
      maxLines: maxLines,
      key: ValueKey(
        valueKey,
      ),
      cursorColor: Colors.blue[100],
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[700],
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontFamily: "Ubuntu",
          fontSize: 16,
        ),
      ),
      onSaved: (quote) {
        text = quote!;
      },
    );
  }
}
