import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Ripple - Water ripple dot matrix indicator
///
/// Continuous water ripple effect spreading from center to outer edges,
/// simulating gentle waves on water surface.
///
/// **Example:**
/// ```dart
/// Ripple(
///   dotSize: 10,
///   activeColor: Colors.teal,
///   animationSpeed: Duration(milliseconds: 1800),
/// )
/// ```
class Ripple extends DotIndicator {
  const Ripple({
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

    // Ripple effect: center -> first layer -> second layer, continuous waves
    // Dual ripple effect: two waves propagating simultaneously

    // Center (ripple source, dual pulse)
    final centerPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.08, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.10, q3, CssCurves.easeIn),
      KeyframeDot(0.12, half, CssCurves.easeIn),
      KeyframeDot(0.14, q1, CssCurves.easeIn),
      KeyframeDot(0.16, DotState.inactive, Curves.linear),
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
      KeyframeDot(0.70, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.94, q1, CssCurves.easeOut),
      KeyframeDot(0.96, half, CssCurves.easeOut),
      KeyframeDot(0.98, q3, CssCurves.easeOut),
      KeyframeDot(1.00, DotState.active),
    ];

    // First layer (cross positions)
    final layer1Pattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave
      KeyframeDot(0.10, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.12, q1, CssCurves.easeOut),
      KeyframeDot(0.14, half, CssCurves.easeOut),
      KeyframeDot(0.16, q3, CssCurves.easeOut),
      KeyframeDot(0.18, DotState.active, Curves.linear),
      KeyframeDot(0.26, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.28, q3, CssCurves.easeIn),
      KeyframeDot(0.30, half, CssCurves.easeIn),
      KeyframeDot(0.32, q1, CssCurves.easeIn),
      KeyframeDot(0.34, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.56, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.58, q1, CssCurves.easeOut),
      KeyframeDot(0.60, half, CssCurves.easeOut),
      KeyframeDot(0.62, q3, CssCurves.easeOut),
      KeyframeDot(0.64, DotState.active, Curves.linear),
      KeyframeDot(0.72, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.74, q3, CssCurves.easeIn),
      KeyframeDot(0.76, half, CssCurves.easeIn),
      KeyframeDot(0.78, q1, CssCurves.easeIn),
      KeyframeDot(0.80, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Second layer (corner positions)
    final layer2Pattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave
      KeyframeDot(0.22, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.24, q1, CssCurves.easeOut),
      KeyframeDot(0.26, half, CssCurves.easeOut),
      KeyframeDot(0.28, q3, CssCurves.easeOut),
      KeyframeDot(0.30, DotState.active, Curves.linear),
      KeyframeDot(0.38, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.40, q3, CssCurves.easeIn),
      KeyframeDot(0.42, half, CssCurves.easeIn),
      KeyframeDot(0.44, q1, CssCurves.easeIn),
      KeyframeDot(0.46, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.68, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.70, q1, CssCurves.easeOut),
      KeyframeDot(0.72, half, CssCurves.easeOut),
      KeyframeDot(0.74, q3, CssCurves.easeOut),
      KeyframeDot(0.76, DotState.active, Curves.linear),
      KeyframeDot(0.84, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.86, q3, CssCurves.easeIn),
      KeyframeDot(0.88, half, CssCurves.easeIn),
      KeyframeDot(0.90, q1, CssCurves.easeIn),
      KeyframeDot(0.92, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, layer2Pattern), // 0 - Top left (corner)
      evaluateKeyframes(progress, layer1Pattern), // 1 - Top middle (cross)
      evaluateKeyframes(progress, layer2Pattern), // 2 - Top right (corner)
      evaluateKeyframes(progress, layer1Pattern), // 3 - Middle left (cross)
      evaluateKeyframes(progress, centerPattern), // 4 - Center
      evaluateKeyframes(progress, layer1Pattern), // 5 - Middle right (cross)
      evaluateKeyframes(progress, layer2Pattern), // 6 - Bottom left (corner)
      evaluateKeyframes(progress, layer1Pattern), // 7 - Bottom middle (cross)
      evaluateKeyframes(progress, layer2Pattern), // 8 - Bottom right (corner)
    ];
  }
}
