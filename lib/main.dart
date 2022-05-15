import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quotes_app/screens/welcome_screen.dart';
import 'package:quotes_app/widgets/routes.dart';

import 'models/quotes.dart';
import 'screens/tabs_screen.dart';
// import 'theme/app_state_notifier.dart';
// import 'theme/app_theme.dart';

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
  // InterstitialAd _interstitialAd;

  // InterstitialAd _createInterstitialAd() {
  //   return InterstitialAd(
  //       adUnitId: "ca-app-pub-2589764057313070/6802613276",
  //       listener: (MobileAdEvent mobileAdEvent) {
  //         print(
  //           "Interstitial Ad $mobileAdEvent",
  //         );
  //       });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   FirebaseAdMob.instance.initialize(
  //     appId: "ca-app-pub-2589764057313070~7515276756",
  //   );

  //   _interstitialAd = _createInterstitialAd()
  //     ..load()
  //     ..show();
  // }

  // @override
  // void dispose() {
  //   super.dispose();

  //   _interstitialAd.dispose();
  // }

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
          // ChangeNotifierProvider.value(
          //   value: AppStateNotifier(),
          // ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          // theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          // themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasData) {
                return TabsScreen();
              }
              return WelcomeScreen();
            },
          ),
          routes: QuotesRoutes().quotesRoutes(),
        ),
      ),
    );
  }
}
