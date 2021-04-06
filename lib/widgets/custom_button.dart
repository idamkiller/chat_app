import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        elevation: MaterialStateProperty.all<double>(2.0),
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      ),
      onPressed: this.onPress,
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
