import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/loading.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:chat_app/pages/users.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => UsersPage(),
  'chat': (_) => ChatPage(),
  'loading': (_) => LoadingPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
};
