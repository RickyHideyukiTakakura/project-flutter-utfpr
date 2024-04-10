import 'package:flutter/material.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => FavoriteRepository(),
      )
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
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.dark(
          // Mantenha a base escura mas faça ajustes para claridade onde necessário
          primary: Colors.indigo, // Cor primária
          secondary: Colors.indigoAccent, // Cor secundária
          surface: Colors.grey[850]!, // Cor da superfície, levemente mais clara
          background: Colors.grey[900]!, // Cor de fundo, mantendo escura
          onPrimary: Colors
              .white, // Cor para contrastar com a primária (para texto/icons)
          onSecondary: Colors.white, // Cor para contrastar com a secundária
          onSurface: Colors.white, // Cor para contrastar com a superfície
          onBackground: Colors.white, // Cor para contrastar com o fundo
          onError: Colors.white, // Cor para contrastar com erros
          brightness: Brightness.dark, // Mantendo o tema geral escuro
        ),
      ),
      home: const HomePage(),
    );
  }
}
