import 'package:flutter/material.dart';

class CustomLabels extends StatelessWidget {
  final String ruta;
  final String title;
  final String subtitle;

  CustomLabels({
    Key key,
    @required this.ruta,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text(
              this.subtitle,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
