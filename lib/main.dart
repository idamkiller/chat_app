import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
