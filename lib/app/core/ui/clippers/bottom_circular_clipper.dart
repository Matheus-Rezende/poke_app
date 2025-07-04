import 'package:flutter/cupertino.dart';

class BottomCircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Começa no topo esquerdo
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 100);

    // Arco circular na parte inferior
    path.quadraticBezierTo(size.width / 2, size.height + 100, size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
