import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:flutter_shopping_list/screens/authenticate/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_list/screens/user/home_page.dart';
import 'firebase_options.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)),
          StreamProvider<SimpleUser?>.value(
              value: AuthenticationService(FirebaseAuth.instance).user,
              initialData: null),
        ],
        child: MaterialApp(
          title: 'Shopping list',
          theme: ThemeData(
            canvasColor: Colors.green.shade200,
            backgroundColor: Colors.green.shade200,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.green.shade200, elevation: 0),
            textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.green.shade200),
                subtitle1: TextStyle(color: Colors.green.shade200)),
            inputDecorationTheme: const InputDecorationTheme(
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 165, 214, 167)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 165, 214, 167), width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 165, 214, 167),
                        width: 2.0))),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade200)),
            ),
          ),
          home: const AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<SimpleUser?>();
    if (firebaseUser != null) {
      return const HomePage();
    }
    return const SignInPage();
  }
}
