import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return Colors.grey;
          return Colors.blue; // Defer to the widget's default.
        }),
        elevation: MaterialStateProperty.all<double>(2.0),
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      ),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 45,
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
