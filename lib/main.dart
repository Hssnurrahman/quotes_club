
import 'package:firebase_admob/firebase_admob.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quotes_app/screens/feedback_screen.dart';
import 'package:quotes_app/screens/privacy_policy_screen.dart';
import 'package:quotes_app/screens/profile_screen.dart';
import 'package:quotes_app/screens/user_guide_screen.dart';
import 'package:quotes_app/screens/welcome_screen.dart';

import 'models/quotes.dart';
import 'screens/contact_us_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/whats_new_screen.dart';
import 'theme/app_state_notifier.dart';
import 'theme/app_theme.dart';

// const String testDevice = "Mobile_id";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  InterstitialAd _interstitialAd;

  InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-2589764057313070/6802613276",
        listener: (MobileAdEvent mobileAdEvent) {
          print(
            "Interstitial Ad $mobileAdEvent",
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAdMob.instance.initialize(
      appId: "ca-app-pub-2589764057313070~7515276756",
    );

    _interstitialAd = _createInterstitialAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.black.withOpacity(
        0.8,
      ),
      radius: 20,
      duration: Duration(
        seconds: 3,
      ),
      position: ToastPosition.bottom,
      textPadding: EdgeInsets.all(
        10,
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontFamily: "Ubuntu",
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Quotes(),
          ),
          ChangeNotifierProvider.value(
            value: AppStateNotifier(),
          ),
        ],
        child: Consumer<AppStateNotifier>(
          builder: (context, appState, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return TabsScreen();
                }
                return WelcomeScreen();
              },
            ),
            routes: {
              TabsScreen.routeName: (ctx) => TabsScreen(),
              WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
              UserGuideScreen.routeName: (ctx) => UserGuideScreen(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
              WhatsNewScreen.routeName: (ctx) => WhatsNewScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
              PrivacyPolicyScreen.routeName: (ctx) => PrivacyPolicyScreen(),
            },
          ),
        ),
      ),
    );
  }
}
