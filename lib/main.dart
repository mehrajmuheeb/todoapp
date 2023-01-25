import 'package:base_flutter/firebase_options.dart';
import 'package:base_flutter/helpers/app_state.dart';
import 'package:base_flutter/helpers/service_locator.dart';
import 'package:base_flutter/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/mixin/auth_mixin.dart';

Future<void> main() async {
  setupServices();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const BaseApp());
}

final scaffoldState = GlobalKey<ScaffoldState>();

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  final _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        key: scaffoldState,
        home: FutureBuilder(
          future: _appState.checkForLoginCredentials(),
          builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
            return (snapshot.connectionState == ConnectionState.done)
                ? _getLauncherScreen(snapshot.data)
                : Container();
          },
        ));
  }

  //Returns the Starting Screen of Application based on the application journey
  //of the User.
  Widget _getLauncherScreen(List<bool>? data) {
    if (data == null) return Container();

    var isOnBoarded = data[0];
    var isLoggedIn = data[1];

    if (!isLoggedIn) {
      return const LoginScreen();
    } else {
      //Dashboard
      return Container();
    }
  }
}
