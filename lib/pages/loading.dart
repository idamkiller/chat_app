import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Autenticando'),
          );
        },
      ),
    );
  }

  Future _checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.isLoggedIn();

    if (authenticated) {
      Navigator.pushReplacementNamed(context, 'users');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
