import 'package:flutter/material.dart';

bool isNumeric(String value) {
  if (value == null) {
    return false;
  }

  final parse = num.tryParse(value);

  bool result = parse == null ? false : true;

  return result;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información Incorrecta'),
          content: Text(mensaje),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
