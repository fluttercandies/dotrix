import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Flip - Flipping dot matrix indicator
///
/// Horizontal page flip effect, alternating left-to-right and
/// right-to-left, creating a continuous flipping animation.
///
/// **Example:**
/// ```dart
/// Flip(
///   dotSize: 14,
///   activeColor: Colors.brown,
///   animationSpeed: Duration(milliseconds: 1800),
/// )
/// ```
class Flip extends DotIndicator {
  const Flip({
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
    super.animationSpeed = const Duration(milliseconds: 900),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Progressive state definitions
    const q1 = DotState(opacity: 0.3, scale: 1.025);
    const half = DotState(opacity: 0.55, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Page flip effect: left -> middle -> right -> middle -> left (back and forth)
    // 0-50%: left -> middle -> right
    // 50-100%: right -> middle -> left

    // Left column
    final leftPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.12, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.14, q3, CssCurves.easeIn),
      KeyframeDot(0.16, half, CssCurves.easeIn),
      KeyframeDot(0.18, q1, CssCurves.easeIn),
      KeyframeDot(0.20, DotState.inactive, Curves.linear),
      // Return
      KeyframeDot(0.80, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.82, q1, CssCurves.easeOut),
      KeyframeDot(0.84, half, CssCurves.easeOut),
      KeyframeDot(0.86, q3, CssCurves.easeOut),
      KeyframeDot(0.88, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // Middle column
    final midPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // Forward
      KeyframeDot(0.15, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.17, q1, CssCurves.easeOut),
      KeyframeDot(0.19, half, CssCurves.easeOut),
      KeyframeDot(0.21, q3, CssCurves.easeOut),
      KeyframeDot(0.23, DotState.active, Curves.linear),
      KeyframeDot(0.35, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.37, q3, CssCurves.easeIn),
      KeyframeDot(0.39, half, CssCurves.easeIn),
      KeyframeDot(0.41, q1, CssCurves.easeIn),
      KeyframeDot(0.43, DotState.inactive, Curves.linear),
      // Backward
      KeyframeDot(0.57, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.59, q1, CssCurves.easeOut),
      KeyframeDot(0.61, half, CssCurves.easeOut),
      KeyframeDot(0.63, q3, CssCurves.easeOut),
      KeyframeDot(0.65, DotState.active, Curves.linear),
      KeyframeDot(0.77, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.79, q3, CssCurves.easeIn),
      KeyframeDot(0.81, half, CssCurves.easeIn),
      KeyframeDot(0.83, q1, CssCurves.easeIn),
      KeyframeDot(0.85, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Right column
    final rightPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.38, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.40, q1, CssCurves.easeOut),
      KeyframeDot(0.42, half, CssCurves.easeOut),
      KeyframeDot(0.44, q3, CssCurves.easeOut),
      KeyframeDot(0.46, DotState.active, Curves.linear),
      KeyframeDot(0.54, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.56, q3, CssCurves.easeIn),
      KeyframeDot(0.58, half, CssCurves.easeIn),
      KeyframeDot(0.60, q1, CssCurves.easeIn),
      KeyframeDot(0.62, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, leftPattern), // 0 - Top left (left column)
      evaluateKeyframes(progress, midPattern), // 1 - Top middle (middle column)
      evaluateKeyframes(progress, rightPattern), // 2 - Top right (right column)
      evaluateKeyframes(progress, leftPattern), // 3 - Left middle (left column)
      evaluateKeyframes(
        progress,
        midPattern,
      ), // 4 - Middle center (middle column)
      evaluateKeyframes(
        progress,
        rightPattern,
      ), // 5 - Right middle (right column)
      evaluateKeyframes(progress, leftPattern), // 6 - Bottom left (left column)
      evaluateKeyframes(
        progress,
        midPattern,
      ), // 7 - Bottom middle (middle column)
      evaluateKeyframes(
        progress,
        rightPattern,
      ), // 8 - Bottom right (right column)
    ];
  }
}
