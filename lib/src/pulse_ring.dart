import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// PulseRing - Pulsing ring dot matrix indicator
///
/// Ring-shaped pulses continuously spreading from center to outer edges,
/// creating concentric ripple patterns.
///
/// **Example:**
/// ```dart
/// PulseRing(
///   dotSize: 10,
///   activeColor: Colors.blueGrey,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class PulseRing extends DotIndicator {
  const PulseRing({
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

    // Pulsing ring effect: center -> first ring -> second ring, continuous pulses

    // Center (pulse source, dual pulse)
    final centerPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.10, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.12, q3, CssCurves.easeIn),
      KeyframeDot(0.14, half, CssCurves.easeIn),
      KeyframeDot(0.16, q1, CssCurves.easeIn),
      KeyframeDot(0.18, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.48, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.50, q1, CssCurves.easeOut),
      KeyframeDot(0.52, half, CssCurves.easeOut),
      KeyframeDot(0.54, q3, CssCurves.easeOut),
      KeyframeDot(0.56, DotState.active, Curves.linear),
      KeyframeDot(0.66, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.68, q3, CssCurves.easeIn),
      KeyframeDot(0.70, half, CssCurves.easeIn),
      KeyframeDot(0.72, q1, CssCurves.easeIn),
      KeyframeDot(0.74, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.94, q1, CssCurves.easeOut),
      KeyframeDot(0.96, half, CssCurves.easeOut),
      KeyframeDot(0.98, q3, CssCurves.easeOut),
      KeyframeDot(1.00, DotState.active),
    ];

    // First ring (cross positions, 10% delay)
    final ring1Pattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave
      KeyframeDot(0.08, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.10, q1, CssCurves.easeOut),
      KeyframeDot(0.12, half, CssCurves.easeOut),
      KeyframeDot(0.14, q3, CssCurves.easeOut),
      KeyframeDot(0.16, DotState.active, Curves.linear),
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
      KeyframeDot(0.74, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.76, q3, CssCurves.easeIn),
      KeyframeDot(0.78, half, CssCurves.easeIn),
      KeyframeDot(0.80, q1, CssCurves.easeIn),
      KeyframeDot(0.82, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    // Second ring (corner positions, 20% delay)
    final ring2Pattern = [
      KeyframeDot(0.00, DotState.inactive, Curves.linear),
      // First wave
      KeyframeDot(0.18, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.20, q1, CssCurves.easeOut),
      KeyframeDot(0.22, half, CssCurves.easeOut),
      KeyframeDot(0.24, q3, CssCurves.easeOut),
      KeyframeDot(0.26, DotState.active, Curves.linear),
      KeyframeDot(0.36, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.38, q3, CssCurves.easeIn),
      KeyframeDot(0.40, half, CssCurves.easeIn),
      KeyframeDot(0.42, q1, CssCurves.easeIn),
      KeyframeDot(0.44, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.66, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.68, q1, CssCurves.easeOut),
      KeyframeDot(0.70, half, CssCurves.easeOut),
      KeyframeDot(0.72, q3, CssCurves.easeOut),
      KeyframeDot(0.74, DotState.active, Curves.linear),
      KeyframeDot(0.84, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.86, q3, CssCurves.easeIn),
      KeyframeDot(0.88, half, CssCurves.easeIn),
      KeyframeDot(0.90, q1, CssCurves.easeIn),
      KeyframeDot(0.92, DotState.inactive, Curves.linear),
      KeyframeDot(1.00, DotState.inactive),
    ];

    return [
      evaluateKeyframes(progress, ring2Pattern), // 0 - Top left (second ring)
      evaluateKeyframes(progress, ring1Pattern), // 1 - Top middle (first ring)
      evaluateKeyframes(progress, ring2Pattern), // 2 - Top right (second ring)
      evaluateKeyframes(progress, ring1Pattern), // 3 - Middle left (first ring)
      evaluateKeyframes(progress, centerPattern), // 4 - Center
      evaluateKeyframes(
        progress,
        ring1Pattern,
      ), // 5 - Middle right (first ring)
      evaluateKeyframes(
        progress,
        ring2Pattern,
      ), // 6 - Bottom left (second ring)
      evaluateKeyframes(
        progress,
        ring1Pattern,
      ), // 7 - Bottom middle (first ring)
      evaluateKeyframes(
        progress,
        ring2Pattern,
      ), // 8 - Bottom right (second ring)
    ];
  }
}
