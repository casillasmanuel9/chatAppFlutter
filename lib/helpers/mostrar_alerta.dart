import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
                elevation: 5,
                textColor: Colors.blue,
              )
            ],
          );
        });
  }

  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(titulo),
          content: Text(subtitulo),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
}
