import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Checkerboard - Checkerboard dot matrix indicator
///
/// Checkerboard alternating flash effect where dots continuously alternate
/// in a checkerboard pattern.
///
/// **Example:**
/// ```dart
/// Checkerboard(
///   dotSize: 14,
///   activeColor: Colors.black87,
///   animationSpeed: Duration(milliseconds: 1200),
/// )
/// ```
class Checkerboard extends DotIndicator {
  const Checkerboard({
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
    // Progressive state definitions
    const q1 = DotState(opacity: 0.3, scale: 1.025);
    const half = DotState(opacity: 0.55, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // White square pattern: 0% active, 50% inactive, 100% back to active (cross-cycle continuous)
    final whitePattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.20, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.23, q3, CssCurves.easeIn),
      KeyframeDot(0.26, half, CssCurves.easeIn),
      KeyframeDot(0.29, q1, CssCurves.easeIn),
      KeyframeDot(0.32, DotState.inactive, Curves.linear),
      KeyframeDot(0.68, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.71, q1, CssCurves.easeOut),
      KeyframeDot(0.74, half, CssCurves.easeOut),
      KeyframeDot(0.77, q3, CssCurves.easeOut),
      KeyframeDot(0.80, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // Black square pattern: 0% inactive, 50% active, 100% back to inactive (staggered with white)
    final blackPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.18, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.21, q1, CssCurves.easeOut),
      KeyframeDot(0.24, half, CssCurves.easeOut),
      KeyframeDot(0.27, q3, CssCurves.easeOut),
      KeyframeDot(0.30, DotState.active, Curves.linear),
      KeyframeDot(0.70, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.73, q3, CssCurves.easeIn),
      KeyframeDot(0.76, half, CssCurves.easeIn),
      KeyframeDot(0.79, q1, CssCurves.easeIn),
      KeyframeDot(0.82, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, whitePattern), // 0 - Top left (white square)
      evaluateKeyframes(
        progress,
        blackPattern,
      ), // 1 - Top middle (black square)
      evaluateKeyframes(progress, whitePattern), // 2 - Top right (white square)
      evaluateKeyframes(
        progress,
        blackPattern,
      ), // 3 - Left middle (black square)
      evaluateKeyframes(progress, whitePattern), // 4 - Center (white square)
      evaluateKeyframes(
        progress,
        blackPattern,
      ), // 5 - Right middle (black square)
      evaluateKeyframes(
        progress,
        whitePattern,
      ), // 6 - Bottom left (white square)
      evaluateKeyframes(
        progress,
        blackPattern,
      ), // 7 - Bottom middle (black square)
      evaluateKeyframes(
        progress,
        whitePattern,
      ), // 8 - Bottom right (white square)
    ];
  }
}
