import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLogo(
                  title: 'Login',
                ),
                _Form(),
                SizedBox(height: 10),
                CustomLabels(
                  ruta: 'register',
                  title: '¿No tienes cuenta?',
                  subtitle: 'Crea una ahora!',
                ),
                SizedBox(height: 10),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            hintText: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: _emailController,
          ),
          SizedBox(height: 20),
          CustomInput(
            icon: Icons.lock_outline,
            hintText: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: _passwordController,
            isPassword: true,
          ),
          SizedBox(height: 10),
          CustomButton(
            text: 'Ingresar',
            onPressed: authService.isLogin
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginState = await authService.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim());

                    if (loginState) {
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Error al ingresar',
                          'Revise sus credenciales');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
