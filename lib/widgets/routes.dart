import 'package:flutter/material.dart';
import 'package:quotes_app/screens/contact_us_screen.dart';
import 'package:quotes_app/screens/feedback_screen.dart';
import 'package:quotes_app/screens/privacy_policy_screen.dart';
import 'package:quotes_app/screens/settings_screen.dart';
import 'package:quotes_app/screens/tabs_screen.dart';
import 'package:quotes_app/screens/user_guide_screen.dart';
import 'package:quotes_app/screens/welcome_screen.dart';
import 'package:quotes_app/screens/whats_new_screen.dart';

class QuotesRoutes {
  quotesRoutes() {
    return {
      TabsScreen.routeName: (ctx) => TabsScreen(),
      WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
      UserGuideScreen.routeName: (ctx) => UserGuideScreen(),
      SettingsScreen.routeName: (ctx) => SettingsScreen(),
      ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
      WhatsNewScreen.routeName: (ctx) => WhatsNewScreen(),
      FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
      PrivacyPolicyScreen.routeName: (ctx) => PrivacyPolicyScreen(),
    };
  }
}
