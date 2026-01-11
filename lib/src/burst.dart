import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Burst - Burst dot matrix indicator
///
/// Center burst effect. The center dot activates first, followed by the
/// four side dots, and finally the four corner dots, creating an
/// outward explosion animation.
///
/// **Example:**
/// ```dart
/// Burst(
///   dotSize: 12,
///   activeColor: Colors.red,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
///
/// Duration: 1150ms
/// Center → sides → corners burst pattern
class Burst extends DotIndicator {
  const Burst({
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
    // Four corners (dot-1/3/7/9): 0% linear → 17.39% ease-in → 30.43% active ease-out → 82.61% inactive linear
    // Four sides (dot-2/4/6/8): 0% ease-in → 13.04% active ease-out → 65.22% inactive linear → 82.61% linear
    // Center (dot-5): 0% active ease-out → 52.17% inactive linear → 69.57% linear → 86.96% ease-in → 100% active

    // Four corners pattern
    final cornerPattern = [
      KeyframeDot(0.0000, DotState.inactive, Curves.linear),
      KeyframeDot(0.1739, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.3043, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.8261, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Four sides pattern
    final edgePattern = [
      KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.1304, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.6522, DotState.inactive, Curves.linear),
      KeyframeDot(0.8261, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Center pattern (cross-cycle loop)
    final centerPattern = [
      KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.5217, DotState.inactive, Curves.linear),
      KeyframeDot(0.6957, DotState.inactive, Curves.linear),
      KeyframeDot(0.8696, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(1.0000, DotState.active),
    ];

    return [
      evaluateKeyframes(progress, cornerPattern), // dot-0: Four corners
      evaluateKeyframes(progress, edgePattern), // dot-1: Four sides
      evaluateKeyframes(progress, cornerPattern), // dot-2: Four corners
      evaluateKeyframes(progress, edgePattern), // dot-3: Four sides
      evaluateKeyframes(progress, centerPattern), // dot-4: Center
      evaluateKeyframes(progress, edgePattern), // dot-5: Four sides
      evaluateKeyframes(progress, cornerPattern), // dot-6: Four corners
      evaluateKeyframes(progress, edgePattern), // dot-7: Four sides
      evaluateKeyframes(progress, cornerPattern), // dot-8: Four corners
    ];
  }
}
