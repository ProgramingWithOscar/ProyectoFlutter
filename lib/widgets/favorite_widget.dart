import 'package:flutter/material.dart';
class FavoriteWidget extends StatelessWidget {
  final String url;

  const FavoriteWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class FieldContainer extends StatelessWidget {
  final String labelText;
  final String helperText;
  final Icon icono;

  const FieldContainer({
    Key? key,
    required this.labelText,
    required this.helperText,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        icon: icono,
        labelText: labelText,
        helperText: helperText,
        filled: true,
      ),
    );
  }
}
