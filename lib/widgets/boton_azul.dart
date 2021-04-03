import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonAzul({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      elevation: 2,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        height: 55,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
