import 'package:flutter/material.dart';
import 'features/auth/ui/login_page.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/feed/ui/feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      /// todo criar classe para rotas
      routes: {
        '/login': (_) => LoginPage(),
      },
      /// todo criar outra alternativa ao inves do onGeneratorRoute
      onGenerateRoute: (settings) {
        if (settings.name == '/feed') {
          final args = settings.arguments as AuthUser;
          return MaterialPageRoute(
            builder: (_) => FeedPage(
              username: args.username,
              token: args.token,
            ),
          );
        }
        return null;
      },
    );
  }
}

