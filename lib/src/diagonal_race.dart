import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// DiagonalRace - Diagonal race dot matrix indicator
///
/// Two diagonals alternate chasing each other, creating a continuous
/// racing effect across the matrix.
///
/// **Example:**
/// ```dart
/// DiagonalRace(
///   dotSize: 12,
///   activeColor: Colors.redAccent,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
class DiagonalRace extends DotIndicator {
  const DiagonalRace({
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
    super.animationSpeed = const Duration(milliseconds: 1000),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Progressive state definitions
    const q1 = DotState(opacity: 0.3, scale: 1.025);
    const half = DotState(opacity: 0.55, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Diagonal 1: Top left -> Center -> Bottom right (0->4->8)
    // Diagonal 2: Top right -> Center -> Bottom left (2->4->6)
    // Alternate activation creates racing effect

    // Diagonal 1 start (top left)
    final diag1Start = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.12, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.14, q3, CssCurves.easeIn),
      KeyframeDot(0.16, half, CssCurves.easeIn),
      KeyframeDot(0.18, q1, CssCurves.easeIn),
      KeyframeDot(0.20, DotState.inactive, Curves.linear),
      KeyframeDot(0.88, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.90, q1, CssCurves.easeOut),
      KeyframeDot(0.92, half, CssCurves.easeOut),
      KeyframeDot(0.94, q3, CssCurves.easeOut),
      KeyframeDot(0.96, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // Diagonal 2 start (top right), 50% delay
    final diag2Start = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.38, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.40, q1, CssCurves.easeOut),
      KeyframeDot(0.42, half, CssCurves.easeOut),
      KeyframeDot(0.44, q3, CssCurves.easeOut),
      KeyframeDot(0.46, DotState.active, Curves.linear),
      KeyframeDot(0.58, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.60, q3, CssCurves.easeIn),
      KeyframeDot(0.62, half, CssCurves.easeIn),
      KeyframeDot(0.64, q1, CssCurves.easeIn),
      KeyframeDot(0.66, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Center point (diagonal intersection)
    final center = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave (diagonal 1 passes)
      KeyframeDot(0.13, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.15, q1, CssCurves.easeOut),
      KeyframeDot(0.17, half, CssCurves.easeOut),
      KeyframeDot(0.19, q3, CssCurves.easeOut),
      KeyframeDot(0.21, DotState.active, Curves.linear),
      KeyframeDot(0.33, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.35, q3, CssCurves.easeIn),
      KeyframeDot(0.37, half, CssCurves.easeIn),
      KeyframeDot(0.39, q1, CssCurves.easeIn),
      KeyframeDot(0.41, DotState.inactive, Curves.linear),
      // Second wave (diagonal 2 passes)
      KeyframeDot(0.51, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.53, q1, CssCurves.easeOut),
      KeyframeDot(0.55, half, CssCurves.easeOut),
      KeyframeDot(0.57, q3, CssCurves.easeOut),
      KeyframeDot(0.59, DotState.active, Curves.linear),
      KeyframeDot(0.71, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.73, q3, CssCurves.easeIn),
      KeyframeDot(0.75, half, CssCurves.easeIn),
      KeyframeDot(0.77, q1, CssCurves.easeIn),
      KeyframeDot(0.79, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Diagonal 1 end (bottom right)
    final diag1End = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.28, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.30, q1, CssCurves.easeOut),
      KeyframeDot(0.32, half, CssCurves.easeOut),
      KeyframeDot(0.34, q3, CssCurves.easeOut),
      KeyframeDot(0.36, DotState.active, Curves.linear),
      KeyframeDot(0.48, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.50, q3, CssCurves.easeIn),
      KeyframeDot(0.52, half, CssCurves.easeIn),
      KeyframeDot(0.54, q1, CssCurves.easeIn),
      KeyframeDot(0.56, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Diagonal 2 end (bottom left)
    final diag2End = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      KeyframeDot(0.66, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.68, q1, CssCurves.easeOut),
      KeyframeDot(0.70, half, CssCurves.easeOut),
      KeyframeDot(0.72, q3, CssCurves.easeOut),
      KeyframeDot(0.74, DotState.active, Curves.linear),
      KeyframeDot(0.86, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.88, q3, CssCurves.easeIn),
      KeyframeDot(0.90, half, CssCurves.easeIn),
      KeyframeDot(0.92, q1, CssCurves.easeIn),
      KeyframeDot(0.94, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Edge points (observers) - Dual wave effect
    final edge = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave
      KeyframeDot(0.08, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.10, q1, CssCurves.easeOut),
      KeyframeDot(0.12, half, CssCurves.easeOut),
      KeyframeDot(0.14, q3, CssCurves.easeOut),
      KeyframeDot(0.16, DotState.active, Curves.linear),
      KeyframeDot(0.24, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.26, q3, CssCurves.easeIn),
      KeyframeDot(0.28, half, CssCurves.easeIn),
      KeyframeDot(0.30, q1, CssCurves.easeIn),
      KeyframeDot(0.32, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.46, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.48, q1, CssCurves.easeOut),
      KeyframeDot(0.50, half, CssCurves.easeOut),
      KeyframeDot(0.52, q3, CssCurves.easeOut),
      KeyframeDot(0.54, DotState.active, Curves.linear),
      KeyframeDot(0.62, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.64, q3, CssCurves.easeIn),
      KeyframeDot(0.66, half, CssCurves.easeIn),
      KeyframeDot(0.68, q1, CssCurves.easeIn),
      KeyframeDot(0.70, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(
        progress,
        diag1Start,
      ), // 0 - Top left (diagonal 1 start)
      evaluateKeyframes(progress, edge), // 1 - Top middle (edge)
      evaluateKeyframes(
        progress,
        diag2Start,
      ), // 2 - Top right (diagonal 2 start)
      evaluateKeyframes(progress, edge), // 3 - Left middle (edge)
      evaluateKeyframes(progress, center), // 4 - Center (intersection)
      evaluateKeyframes(progress, edge), // 5 - Right middle (edge)
      evaluateKeyframes(progress, diag2End), // 6 - Bottom left (diagonal 2 end)
      evaluateKeyframes(progress, edge), // 7 - Bottom middle (edge)
      evaluateKeyframes(
        progress,
        diag1End,
      ), // 8 - Bottom right (diagonal 1 end)
    ];
  }
}
