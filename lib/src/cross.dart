import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Cross - Cross dot matrix indicator
///
/// Cross-shaped spreading effect. Four corners activate first and fade,
/// followed by the four side dots, with a brief center activation.
///
/// **Example:**
/// ```dart
/// Cross(
///   dotSize: 12,
///   activeColor: Colors.amber,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
///
/// Duration: 1150ms
/// Cross pattern: corners → sides → center
class Cross extends DotIndicator {
  const Cross({
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
    super.animationSpeed = const Duration(milliseconds: 1150),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Four corners (dot-1,3,7,9): 0% active → 17.39% ease-out → 69.57% inactive → 82.61% ease-in active → 100% active
    // Four sides (dot-2,4,6,8): 0% inactive → 17.39% ease-in → 30.43% active → 82.61% ease-out inactive
    // Center (dot-5): 0% ease-in → 13.04% active → 47.83% ease-out → 100% inactive

    // Four corners pattern
    final cornerPattern = [
      KeyframeDot(0.0000, DotState.active, Curves.linear),
      KeyframeDot(0.1739, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.6957, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.8261, DotState.active, Curves.linear),
      KeyframeDot(1.0000, DotState.active),
    ];

    // Four sides pattern
    final edgePattern = [
      KeyframeDot(0.0000, DotState.inactive, Curves.linear),
      KeyframeDot(0.1739, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.3043, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.8261, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Center pattern
    final centerPattern = [
      KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.1304, DotState.active, Curves.linear),
      KeyframeDot(0.3043, DotState.active, Curves.linear),
      KeyframeDot(0.4783, DotState.active, CssCurves.easeOut),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, cornerPattern), // dot-0: Top left corner
      evaluateKeyframes(progress, edgePattern), // dot-1: Top middle
      evaluateKeyframes(progress, cornerPattern), // dot-2: Top right corner
      evaluateKeyframes(progress, edgePattern), // dot-3: Left middle
      evaluateKeyframes(progress, centerPattern), // dot-4: Center
      evaluateKeyframes(progress, edgePattern), // dot-5: Right middle
      evaluateKeyframes(progress, cornerPattern), // dot-6: Bottom left corner
      evaluateKeyframes(progress, edgePattern), // dot-7: Bottom middle
      evaluateKeyframes(progress, cornerPattern), // dot-8: Bottom right corner
    ];
  }
}
