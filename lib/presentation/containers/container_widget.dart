import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String url;
  final String name;
  final VoidCallback? onTap;
  const ContainerWidget(
      {Key? key, required this.url, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            width: 200,
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(
              children: [
                Image.asset(
                  url,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
