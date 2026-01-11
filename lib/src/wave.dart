import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Wave - Wave dot matrix indicator
///
/// Diagonal wave propagation effect. The wave propagates diagonally from
/// top-left to bottom-right, creating a smooth diagonal ripple animation.
///
/// **Example:**
/// ```dart
/// // Basic usage
/// Wave()
///
/// // Customized
/// Wave(
///   dotSize: 14,
///   spacing: 8,
///   activeColor: Colors.cyan,
///   animationSpeed: Duration(milliseconds: 1800),
/// )
/// ```
///
/// Duration: 1350ms
/// Propagates diagonally from top left to bottom right
class Wave extends DotIndicator {
  const Wave({
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
    super.animationSpeed = const Duration(milliseconds: 1350),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Diagonal wave propagation, each layer delayed by approximately 14.81%

    return [
      // dot-0: Top left corner - Layer 1, cross-cycle loop
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4444, DotState.inactive, Curves.linear),
        KeyframeDot(0.5926, DotState.inactive, Curves.linear),
        KeyframeDot(0.7407, DotState.inactive, Curves.linear),
        KeyframeDot(0.8889, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-1: Top middle - Layer 2
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1111, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5556, DotState.inactive, Curves.linear),
        KeyframeDot(0.7037, DotState.inactive, Curves.linear),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-2: Top right corner - Layer 3
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2593, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7037, DotState.inactive, Curves.linear),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-3: Left middle - Layer 2 (same as dot-1)
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1111, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5556, DotState.inactive, Curves.linear),
        KeyframeDot(0.7037, DotState.inactive, Curves.linear),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-4: Center - Layer 3 (same as dot-2)
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2593, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7037, DotState.inactive, Curves.linear),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-5: Right middle - Layer 4
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, Curves.linear),
        KeyframeDot(0.2963, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4074, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-6: Bottom left corner - Layer 3 (same as dot-2)
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2593, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7037, DotState.inactive, Curves.linear),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-7: Bottom middle - Layer 4 (same as dot-5)
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, Curves.linear),
        KeyframeDot(0.2963, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4074, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8519, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-8: Bottom right corner - Layer 5
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1481, DotState.inactive, Curves.linear),
        KeyframeDot(0.2963, DotState.inactive, Curves.linear),
        KeyframeDot(0.4444, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5556, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
    ];
  }
}
