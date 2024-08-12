import 'package:flutter/material.dart';

class Shape extends StatelessWidget {
  const Shape({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/shape.png',
      height: 129,
      width: 141,
    );
  }
}

//Esta clase es solo para aprender, similar a una funcion
//retorna una imagen que se usa varias veces