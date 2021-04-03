import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String fistText;
  final String secondText;

  const Labels(
      {Key key,
      @required this.route,
      this.fistText = 'No tienes cuenta?',
      this.secondText = 'Crear una ahora!'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.fistText,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(
              this.secondText,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
