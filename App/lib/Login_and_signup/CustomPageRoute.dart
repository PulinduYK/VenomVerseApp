import 'package:flutter/material.dart';

class ModernPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ModernPageRoute({required this.page})
      : super(
    transitionDuration: const Duration(milliseconds: 400), // Smooth animation speed
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      // Animations for sliding, scaling , adjustment
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      // Slide
      var slideTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      // Fade
      var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

      // Scale
      var scaleTween = Tween<double>(begin: 1.0, end: 1.0);

      return SlideTransition(
        position: animation.drive(slideTween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        ),
      );
    },
  );
}
class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
  );
}

