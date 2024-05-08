import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/widgets/auth_check.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => FavoriteRepository()),
      ChangeNotifierProvider(create: (context) => ReviewRepository())
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projeto Flutter UTFPR",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple[100]!,
          secondary: Colors.deepPurpleAccent,
          surface: Colors.grey[850]!,
          background: Colors.grey[900]!,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthCheck(),
    );
  }
}
