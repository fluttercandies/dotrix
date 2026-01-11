import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Scatter - Scattering dot matrix indicator
///
/// Continuous scattering effect from center outward, like fireworks
/// or starburst patterns.
///
/// **Example:**
/// ```dart
/// Scatter(
///   dotSize: 12,
///   activeColor: Colors.deepOrange,
///   animationSpeed: Duration(milliseconds: 2500),
/// )
/// ```
class Scatter extends DotIndicator {
  const Scatter({
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

    // Scattering effect: center explosion → sequential scattering in different directions
    // Each outer point has different delay, creating radial scattering pattern

    // Center (explosion source, dual pulse)
    final centerPattern = [
      KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
      KeyframeDot(0.06, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.08, q3, CssCurves.easeIn),
      KeyframeDot(0.10, half, CssCurves.easeIn),
      KeyframeDot(0.12, q1, CssCurves.easeIn),
      KeyframeDot(0.14, DotState.inactive, Curves.linear),
      // Second wave
      KeyframeDot(0.50, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.52, q1, CssCurves.easeOut),
      KeyframeDot(0.54, half, CssCurves.easeOut),
      KeyframeDot(0.56, q3, CssCurves.easeOut),
      KeyframeDot(0.58, DotState.active, Curves.linear),
      KeyframeDot(0.64, DotState.active, CssCurves.easeIn),
      KeyframeDot(0.66, q3, CssCurves.easeIn),
      KeyframeDot(0.68, half, CssCurves.easeIn),
      KeyframeDot(0.70, q1, CssCurves.easeIn),
      KeyframeDot(0.72, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
      KeyframeDot(0.94, q1, CssCurves.easeOut),
      KeyframeDot(0.96, half, CssCurves.easeOut),
      KeyframeDot(0.98, q3, CssCurves.easeOut),
      KeyframeDot(1.00, DotState.active),
    ];

    // Generate scatter point pattern based on delay phase
    List<KeyframeDot> makeScatterPattern(double delay) {
      // First scatter wave
      final s1 = 0.08 + delay * 0.08;
      // Second scatter wave
      final s2 = 0.58 + delay * 0.08;

      return [
        KeyframeDot(0.00, DotState.inactive, Curves.linear),
        // First wave
        KeyframeDot(s1, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(s1 + 0.02, q1, CssCurves.easeOut),
        KeyframeDot(s1 + 0.04, half, CssCurves.easeOut),
        KeyframeDot(s1 + 0.06, q3, CssCurves.easeOut),
        KeyframeDot(s1 + 0.08, DotState.active, Curves.linear),
        KeyframeDot(s1 + 0.16, DotState.active, CssCurves.easeIn),
        KeyframeDot(s1 + 0.18, q3, CssCurves.easeIn),
        KeyframeDot(s1 + 0.20, half, CssCurves.easeIn),
        KeyframeDot(s1 + 0.22, q1, CssCurves.easeIn),
        KeyframeDot(s1 + 0.24, DotState.inactive, Curves.linear),
        // Second wave
        KeyframeDot(s2, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(s2 + 0.02, q1, CssCurves.easeOut),
        KeyframeDot(s2 + 0.04, half, CssCurves.easeOut),
        KeyframeDot(s2 + 0.06, q3, CssCurves.easeOut),
        KeyframeDot(s2 + 0.08, DotState.active, Curves.linear),
        KeyframeDot(s2 + 0.16, DotState.active, CssCurves.easeIn),
        KeyframeDot(s2 + 0.18, q3, CssCurves.easeIn),
        KeyframeDot(s2 + 0.20, half, CssCurves.easeIn),
        KeyframeDot(s2 + 0.22, q1, CssCurves.easeIn),
        KeyframeDot(
          (s2 + 0.24).clamp(0.0, 1.0),
          DotState.inactive,
          Curves.linear,
        ),
        KeyframeDot(1.00, DotState.inactive),
      ];
    }

    return [
      evaluateKeyframes(
        progress,
        makeScatterPattern(2),
      ), // 0 - Top left (delay 2)
      evaluateKeyframes(
        progress,
        makeScatterPattern(0),
      ), // 1 - Top middle (delay 0)
      evaluateKeyframes(
        progress,
        makeScatterPattern(3),
      ), // 2 - Top right (delay 3)
      evaluateKeyframes(
        progress,
        makeScatterPattern(1),
      ), // 3 - Left middle (delay 1)
      evaluateKeyframes(progress, centerPattern), // 4 - Center
      evaluateKeyframes(
        progress,
        makeScatterPattern(1),
      ), // 5 - Right middle (delay 1)
      evaluateKeyframes(
        progress,
        makeScatterPattern(3),
      ), // 6 - Bottom left (delay 3)
      evaluateKeyframes(
        progress,
        makeScatterPattern(0),
      ), // 7 - Bottom middle (delay 0)
      evaluateKeyframes(
        progress,
        makeScatterPattern(2),
      ), // 8 - Bottom right (delay 2)
    ];
  }
}
