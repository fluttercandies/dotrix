import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Diamond - Diamond dot matrix indicator
///
/// Diamond pattern with corners and center flashing briefly while
/// the four sides maintain a longer glow.
///
/// **Example:**
/// ```dart
/// Diamond(
///   dotSize: 12,
///   activeColor: Colors.pink,
///   animationSpeed: Duration(milliseconds: 1000),
/// )
/// ```
///
/// Duration: 750ms
/// Diamond pattern with edge glow
class Diamond extends DotIndicator {
  const Diamond({
    super.key,
    super.dotSize = 8.0,
    super.borderRadius = 0.0,
    super.spacing = 0.0,
    super.activeColor,
    super.inactiveColor,
    super.opacity = 1.0,
    super.shadowColor,
    super.blurRadius = 10.0,
    super.shadowOffset = Offset.zero,
    super.spreadRadius = 0.0,
    super.animationSpeed = const Duration(milliseconds: 750),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Four corners + center (dot-1,3,5,7,9): 0% ease-in → 20% active → ease-out → 100% inactive
    // Four sides (dot-2,4,6,8): 0% active → ease-out → 80% inactive → ease-in → 100% active

    // Four corners + center pattern: Short flash
    final cornerPattern = [
      KeyframeDot(0.00, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.20, DotState.active, CssCurves.easeOut),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Four sides pattern: Long light
    final edgePattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.80, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(1.00, DotState.active),
    ];

    return [
      evaluateKeyframes(progress, cornerPattern), // dot-0: Top left corner
      evaluateKeyframes(progress, edgePattern), // dot-1: Top middle
      evaluateKeyframes(progress, cornerPattern), // dot-2: Top right corner
      evaluateKeyframes(progress, edgePattern), // dot-3: Left middle
      evaluateKeyframes(progress, cornerPattern), // dot-4: Center
      evaluateKeyframes(progress, edgePattern), // dot-5: Right middle
      evaluateKeyframes(progress, cornerPattern), // dot-6: Bottom left corner
      evaluateKeyframes(progress, edgePattern), // dot-7: Bottom middle
      evaluateKeyframes(progress, cornerPattern), // dot-8: Bottom right corner
    ];
  }
}
