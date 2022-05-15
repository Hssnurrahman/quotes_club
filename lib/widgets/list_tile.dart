import 'package:flutter/material.dart';

class QuoteListTile {
  ListTile settingsListTileWithRichTextIcon(
    Function()? onTap,
    IconData icon,
    String titleText,
    IconData iconData,
    Function()? onPressed,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.teal,
        size: 20,
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: titleText,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Ubuntu",
                fontSize: 15,
              ),
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(
                  2,
                  -6,
                ),
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          iconData,
          color: Colors.teal,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }

  ListTile settingsListTileWithIcon(
    Function()? onTap,
    IconData icon,
    String titleText,
    IconData iconData,
    Function()? onPressed,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.teal,
        size: 20,
      ),
      title: Text(
        titleText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Ubuntu",
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          iconData,
          color: Colors.teal,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }

  ListTile settingsListTileWithText(
    IconData icon,
    String titleText,
    String trailingText,
  ) {
    return ListTile(
      leading: Icon(
        Icons.phone_android,
        size: 20,
        color: Colors.teal,
      ),
      title: Text(
        titleText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Ubuntu",
        ),
      ),
      trailing: Text(
        trailingText,
        style: TextStyle(
          fontFamily: "Ubuntu",
          fontSize: 15,
        ),
      ),
    );
  }

  ListTile userGuideListTile(
    String leadingText,
    String titleText,
    String subtitleText,
  ) {
    return ListTile(
      leading: Text(
        leadingText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Ubuntu",
        ),
      ),
      title: Text(
        titleText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: "Ubuntu",
        ),
      ),
      subtitle: Column(
        children: [
          Text(
            subtitleText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Ubuntu",
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  ListTile settingsListTile({
    required IconData? icon,
    required String? titleText,
    required Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20,
        color: Colors.teal,
      ),
      title: Text(
        titleText!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }
}
