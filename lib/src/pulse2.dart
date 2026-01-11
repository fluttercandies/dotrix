import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Pulse2 - Alternative pulse dot matrix indicator
///
/// Complex multi-stage activation with center double-flash, early side
/// activation, and delayed corner activation for a layered pulse effect.
///
/// **Example:**
/// ```dart
/// Pulse2(
///   dotSize: 10,
///   activeColor: Colors.deepPurple,
///   animationSpeed: Duration(milliseconds: 2500),
/// )
/// ```
///
/// Duration: 1950ms
/// Multi-layered pulse with center double-flash
class Pulse2 extends DotIndicator {
  const Pulse2({
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
    super.animationSpeed = const Duration(milliseconds: 1950),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Four corners (dot-1,3,7,9): 41.03% ease-in → 48.72% active → ease-out → 79.49% inactive
    // Four sides (dot-2,4,6,8): 0% ease-in → 7.69% active → ease-out → 38.46% inactive
    // Center (dot-5): Multi-stage - see below

    // Four corners pattern
    final cornerPattern = [
      KeyframeDot(0.0000, DotState.inactive, Curves.linear),
      KeyframeDot(0.1026, DotState.inactive, Curves.linear),
      KeyframeDot(0.2051, DotState.inactive, Curves.linear),
      KeyframeDot(0.3077, DotState.inactive, Curves.linear),
      KeyframeDot(0.4103, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.4872, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.7949, DotState.inactive, Curves.linear),
      KeyframeDot(0.8974, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Four sides pattern
    final edgePattern = [
      KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.0769, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.3846, DotState.inactive, Curves.linear),
      KeyframeDot(0.4872, DotState.inactive, Curves.linear),
      KeyframeDot(0.5897, DotState.inactive, Curves.linear),
      KeyframeDot(0.6923, DotState.inactive, Curves.linear),
      KeyframeDot(0.7949, DotState.inactive, Curves.linear),
      KeyframeDot(0.8974, DotState.inactive, Curves.linear),
      KeyframeDot(1.0000, DotState.inactive),
    ];

    // Center pattern: Double flash
    final centerPattern = [
      KeyframeDot(0.0000, DotState.active, Curves.linear),
      KeyframeDot(0.0870, DotState.active, Curves.linear),
      KeyframeDot(0.1739, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.4348, DotState.inactive, CssCurves.easeIn),
      KeyframeDot(0.5000, DotState.active, Curves.linear),
      KeyframeDot(0.5870, DotState.active, Curves.linear),
      KeyframeDot(0.6739, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.9348, DotState.inactive, CssCurves.easeIn),
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
