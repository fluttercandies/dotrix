import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Spinner - Spinning dot matrix indicator
///
/// Cross rotation lighting effect. The center dot is always lit, corners never
/// activate. Four side dots rotate sequentially (top → right → bottom → left)
/// in a clockwise pattern, creating a smooth "chase" animation effect.
///
/// **Example:**
/// ```dart
/// // Basic usage
/// Spinner()
///
/// // Customized
/// Spinner(
///   dotSize: 10,
///   spacing: 6,
///   activeColor: Colors.blue,
///   animationSpeed: Duration(milliseconds: 600),
/// )
/// ```
///
/// Duration: 800ms
/// Center always lit, corners never activate, four sides rotate clockwise
class Spinner extends DotIndicator {
  const Spinner({
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
    super.animationSpeed = const Duration(milliseconds: 800),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Clockwise rotation: Top(dot-1) -> Right(dot-5) -> Bottom(dot-7) -> Left(dot-3)
    // Each dot occupies 25% of cycle, with overlap forming chase effect
    // Center(dot-4) always active, corners never active

    // Progressive states
    const q1 = DotState(opacity: 0.3, scale: 1.03);
    const half = DotState(opacity: 0.6, scale: 1.06);
    const q3 = DotState(opacity: 0.85, scale: 1.085);

    // Top(dot-1): 0% start activation, forming complete cycle
    final topPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.20, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.25, q3, CssCurves.easeIn),
      KeyframeDot(0.30, half, CssCurves.easeIn),
      KeyframeDot(0.35, q1, CssCurves.easeIn),
      KeyframeDot(0.40, DotState.inactive, Curves.linear),
      KeyframeDot(0.85, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.88, q1, CssCurves.easeOut),
      KeyframeDot(0.91, half, CssCurves.easeOut),
      KeyframeDot(0.94, q3, CssCurves.easeOut),
      KeyframeDot(1.00, DotState.active),
    ];

    // Right(dot-5): 25% activation
    final rightPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.10, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.13, q1, CssCurves.easeOut),
      KeyframeDot(0.16, half, CssCurves.easeOut),
      KeyframeDot(0.19, q3, CssCurves.easeOut),
      KeyframeDot(0.25, DotState.active, Curves.linear),
      KeyframeDot(0.45, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.50, q3, CssCurves.easeIn),
      KeyframeDot(0.55, half, CssCurves.easeIn),
      KeyframeDot(0.60, q1, CssCurves.easeIn),
      KeyframeDot(0.65, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Bottom(dot-7): 50% activation
    final bottomPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.35, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.38, q1, CssCurves.easeOut),
      KeyframeDot(0.41, half, CssCurves.easeOut),
      KeyframeDot(0.44, q3, CssCurves.easeOut),
      KeyframeDot(0.50, DotState.active, Curves.linear),
      KeyframeDot(0.70, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.75, q3, CssCurves.easeIn),
      KeyframeDot(0.80, half, CssCurves.easeIn),
      KeyframeDot(0.85, q1, CssCurves.easeIn),
      KeyframeDot(0.90, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Left(dot-3): 75% activation
    final leftPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.60, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.63, q1, CssCurves.easeOut),
      KeyframeDot(0.66, half, CssCurves.easeOut),
      KeyframeDot(0.69, q3, CssCurves.easeOut),
      KeyframeDot(0.75, DotState.active, Curves.linear),
      KeyframeDot(0.95, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.97, q3, CssCurves.easeIn),
      KeyframeDot(0.98, half, CssCurves.easeIn),
      KeyframeDot(0.99, q1, CssCurves.easeIn),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      DotState.inactive, // dot-0: Top left corner - never active
      evaluateKeyframes(progress, topPattern), // dot-1: Top middle
      DotState.inactive, // dot-2: Top right corner - never active
      evaluateKeyframes(progress, leftPattern), // dot-3: Left middle
      DotState.active, // dot-4: Center - always active
      evaluateKeyframes(progress, rightPattern), // dot-5: Right middle
      DotState.inactive, // dot-6: Bottom left corner - never active
      evaluateKeyframes(progress, bottomPattern), // dot-7: Bottom middle
      DotState.inactive, // dot-8: Bottom right corner - never active
    ];
  }
}
