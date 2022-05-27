import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:flutter_shopping_list/screens/authenticate/sign_in_page.dart';
import 'package:flutter_shopping_list/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_list/screens/user/home_page/home_page.dart';
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
          theme: CustomTheme.lightTheme,
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
