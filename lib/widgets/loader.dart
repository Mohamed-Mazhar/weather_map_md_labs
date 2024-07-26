import 'dart:ui';

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          ),
        ),
        const Positioned(
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
          child: SizedBox(
            width: 64,
            height: 64,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                backgroundColor: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
