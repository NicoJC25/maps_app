import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {super.key,
      required String message,
      String btnLabel = 'OK',
      super.duration = const Duration(seconds: 2),
      VoidCallback? onOk})
      : super(
            content: Text(message),
            action: SnackBarAction(
                label: btnLabel,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                }));
}

//Explicacion rapida:
/**
 * 
 * Se crea una clase para hacer una "Snack bar" propia, esta snack bar es el
 * mensaje que salta en el archivo del widget del FAB. Se establece que se
 * requiere un mensaje, el "btnLabel" es el boton que sale a la derecha del
 * mensaje, y se establece la duracion. Luego, todos estos datos se envian
 * a la snack bar como tal.
 * 
 */