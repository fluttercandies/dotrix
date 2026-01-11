import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Pulse - Pulse dot matrix indicator
///
/// Center to surroundings spreading pulse effect. The center dot activates
/// first, followed by the four side dots, and finally the four corner dots.
/// Creates a smooth outward ripple effect.
///
/// **Example:**
/// ```dart
/// // Basic usage
/// Pulse()
///
/// // Customized
/// Pulse(
///   dotSize: 12,
///   spacing: 4,
///   activeColor: Colors.pink,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
///
/// Duration: 1550ms
/// Center lights first, four sides follow, four corners last
class Pulse extends DotIndicator {
  const Pulse({
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
    super.animationSpeed = const Duration(milliseconds: 1550),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Four corners (dot-1,3,7,9): 0% inactive → 12.90% inactive → 22.58% ease-in active → 61.29% ease-out inactive
    // Four sides (dot-2,4,6,8): 0% ease-in → 9.68% active → 35.48% ease-out → 74.19% inactive
    // Center (dot-5): 0% active → 51.61% ease-out → 90.32% inactive → ease-in → 100% active

    // Four corners pattern
    final cornerPattern = [
      KeyframeDot(0.0000, DotState.inactive, Curves.linear),
      KeyframeDot(0.1290, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.2258, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.6129, DotState.inactive, Curves.linear),
      KeyframeDot(0.7419, DotState.inactive, Curves.linear),
      KeyframeDot(0.8710, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Four sides pattern
    final edgePattern = [
      KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.0968, DotState.active, Curves.linear),
      KeyframeDot(0.2258, DotState.active, Curves.linear),
      KeyframeDot(0.3548, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.7419, DotState.inactive, Curves.linear),
      KeyframeDot(0.8710, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Center pattern
    final centerPattern = [
      KeyframeDot(0.0000, DotState.active, Curves.linear),
      KeyframeDot(0.1290, DotState.active, Curves.linear),
      KeyframeDot(0.2581, DotState.active, Curves.linear),
      KeyframeDot(0.3871, DotState.active, Curves.linear),
      KeyframeDot(0.5161, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.9032, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(1.0000, DotState.active),
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
