import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Converge - Converging dot matrix indicator
///
/// Four sides converge toward the center then spread outward, creating
/// a continuous breathing effect.
///
/// **Example:**
/// ```dart
/// Converge(
///   dotSize: 10,
///   activeColor: Colors.orange,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class Converge extends DotIndicator {
  const Converge({
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
    super.animationSpeed = const Duration(milliseconds: 1200),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Progressive state definitions
    const q1 = DotState(opacity: 0.3, scale: 1.025);
    const half = DotState(opacity: 0.55, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Converge + spread cycle: outer -> middle -> center -> middle -> outer
    // Phase 1 (converging): 0-50%
    // Phase 2 (spreading): 50-100%

    // Outer corners (converge first, spread last)
    final cornerPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.10, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.12, q3, CssCurves.easeIn),
      KeyframeDot(0.14, half, CssCurves.easeIn),
      KeyframeDot(0.16, q1, CssCurves.easeIn),
      KeyframeDot(0.18, DotState.inactive, Curves.linear),
      // Wait for spread
      KeyframeDot(0.82, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.84, q1, CssCurves.easeOut),
      KeyframeDot(0.86, half, CssCurves.easeOut),
      KeyframeDot(0.88, q3, CssCurves.easeOut),
      KeyframeDot(0.90, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // Middle layer (edge points)
    final edgePattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
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
      // Spread phase
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

    // Center (convergence endpoint/spread start point)
    final centerPattern = [
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
