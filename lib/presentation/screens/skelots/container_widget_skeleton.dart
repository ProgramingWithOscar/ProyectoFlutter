import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Importa el paquete Shimmer.

class ContainerWidgetSkeleton extends StatelessWidget {
  const ContainerWidgetSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 120,
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 160,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
