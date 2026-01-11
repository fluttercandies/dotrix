import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Inward - Inward converging dot matrix indicator
///
/// Outer dots shrink inward then spread outward, creating a continuous
/// breathing effect. Starts from the corners.
///
/// **Example:**
/// ```dart
/// Inward(
///   dotSize: 12,
///   activeColor: Colors.purple,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class Inward extends DotIndicator {
  const Inward({
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
    super.animationSpeed = const Duration(milliseconds: 1100),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Progressive state definitions
    const q1 = DotState(opacity: 0.3, scale: 1.025);
    const half = DotState(opacity: 0.55, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Inward effect: corners -> edges -> center -> edges -> corners
    // 0-50%: shrinking
    // 50-100%: spreading

    // Four corners (outermost layer)
    final cornerPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.12, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.14, q3, CssCurves.easeIn),
      KeyframeDot(0.16, half, CssCurves.easeIn),
      KeyframeDot(0.18, q1, CssCurves.easeIn),
      KeyframeDot(0.20, DotState.inactive, Curves.linear),
      // Return during spread
      KeyframeDot(0.80, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.82, q1, CssCurves.easeOut),
      KeyframeDot(0.84, half, CssCurves.easeOut),
      KeyframeDot(0.86, q3, CssCurves.easeOut),
      KeyframeDot(0.88, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // Four edges (middle layer)
    final edgePattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // Shrinking
      KeyframeDot(0.16, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.18, q1, CssCurves.easeOut),
      KeyframeDot(0.20, half, CssCurves.easeOut),
      KeyframeDot(0.22, q3, CssCurves.easeOut),
      KeyframeDot(0.24, DotState.active, Curves.linear),
      KeyframeDot(0.36, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.38, q3, CssCurves.easeIn),
      KeyframeDot(0.40, half, CssCurves.easeIn),
      KeyframeDot(0.42, q1, CssCurves.easeIn),
      KeyframeDot(0.44, DotState.inactive, Curves.linear),
      // Spreading
      KeyframeDot(0.56, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.58, q1, CssCurves.easeOut),
      KeyframeDot(0.60, half, CssCurves.easeOut),
      KeyframeDot(0.62, q3, CssCurves.easeOut),
      KeyframeDot(0.64, DotState.active, Curves.linear),
      KeyframeDot(0.76, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.78, q3, CssCurves.easeIn),
      KeyframeDot(0.80, half, CssCurves.easeIn),
      KeyframeDot(0.82, q1, CssCurves.easeIn),
      KeyframeDot(0.84, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Center (core)
    final centerPattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // Shrinking arrival
      KeyframeDot(0.38, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.40, q1, CssCurves.easeOut),
      KeyframeDot(0.42, half, CssCurves.easeOut),
      KeyframeDot(0.44, q3, CssCurves.easeOut),
      KeyframeDot(0.46, DotState.active, Curves.linear),
      // Spreading start
      KeyframeDot(0.54, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.56, q3, CssCurves.easeIn),
      KeyframeDot(0.58, half, CssCurves.easeIn),
      KeyframeDot(0.60, q1, CssCurves.easeIn),
      KeyframeDot(0.62, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, cornerPattern), // 0 - Top left (corner)
      evaluateKeyframes(progress, edgePattern), // 1 - Top middle (edge)
      evaluateKeyframes(progress, cornerPattern), // 2 - Top right (corner)
      evaluateKeyframes(progress, edgePattern), // 3 - Left middle (edge)
      evaluateKeyframes(progress, centerPattern), // 4 - Center
      evaluateKeyframes(progress, edgePattern), // 5 - Right middle (edge)
      evaluateKeyframes(progress, cornerPattern), // 6 - Bottom left (corner)
      evaluateKeyframes(progress, edgePattern), // 7 - Bottom middle (edge)
      evaluateKeyframes(progress, cornerPattern), // 8 - Bottom right (corner)
    ];
  }
}
