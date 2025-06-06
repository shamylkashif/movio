import 'package:flutter/cupertino.dart';

import '../utils/app-colors.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    required this.icon,
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(
        icon,
        size: size,
        color: white, // Required but overridden
      ),
    );
  }
}
