import 'package:flutter/material.dart';

class ShowDialogCustomer extends StatelessWidget {
   final String titleShow;
  final String contentShow;
  final String urlImageShow;

  ShowDialogCustomer({required this.titleShow, required this.contentShow, required this.urlImageShow});
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleShow),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(contentShow),
          SizedBox(height: 16.0),
          Image.asset(urlImageShow, height: 100),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
        TextButton(
          onPressed: () {
            // Realiza una acción adicional aquí
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
