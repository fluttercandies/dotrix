import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Radial - Radial dot matrix indicator
///
/// Continuous pulsing wave effect spreading from center to outer edges.
/// The center dot stays lit while ripples expand outward.
///
/// **Example:**
/// ```dart
/// Radial(
///   dotSize: 10,
///   activeColor: Colors.cyan,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
class Radial extends DotIndicator {
  const Radial({
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

    // Center stays lit, first and second layers form ripple effect
    // Layer 0 (center-4): Always lit
    // Layer 1 (cross-1,3,5,7): Starts at phase 0
    // Layer 2 (corners-0,2,6,8): 15% phase delay

    // Center dot always lit
    final centerPattern = [
      KeyframeDot(0.00, DotState.active, Curves.linear),
      KeyframeDot(1.00, DotState.active),
    ];

    // First ripple layer
    List<KeyframeDot> layer1Pattern() {
      return [
        KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.12, DotState.active, CssCurves.easeIn),
        KeyframeDot(0.15, q3, CssCurves.easeIn),
        KeyframeDot(0.18, half, CssCurves.easeIn),
        KeyframeDot(0.21, q1, CssCurves.easeIn),
        KeyframeDot(0.24, DotState.inactive, Curves.linear),
        KeyframeDot(0.50, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(0.53, q1, CssCurves.easeOut),
        KeyframeDot(0.56, half, CssCurves.easeOut),
        KeyframeDot(0.59, q3, CssCurves.easeOut),
        KeyframeDot(0.62, DotState.active, Curves.linear),
        KeyframeDot(0.74, DotState.active, CssCurves.easeIn),
        KeyframeDot(0.77, q3, CssCurves.easeIn),
        KeyframeDot(0.80, half, CssCurves.easeIn),
        KeyframeDot(0.83, q1, CssCurves.easeIn),
        KeyframeDot(0.86, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(0.94, q1, CssCurves.easeOut),
        KeyframeDot(0.96, half, CssCurves.easeOut),
        KeyframeDot(0.98, q3, CssCurves.easeOut),
        KeyframeDot(1.00, DotState.active),
      ];
    }

    // Second ripple layer (15% delay)
    List<KeyframeDot> layer2Pattern() {
      return [
        KeyframeDot(0.00, DotState.inactive, Curves.linear),
        KeyframeDot(0.11, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(0.14, q1, CssCurves.easeOut),
        KeyframeDot(0.17, half, CssCurves.easeOut),
        KeyframeDot(0.20, q3, CssCurves.easeOut),
        KeyframeDot(0.23, DotState.active, Curves.linear),
        KeyframeDot(0.35, DotState.active, CssCurves.easeIn),
        KeyframeDot(0.38, q3, CssCurves.easeIn),
        KeyframeDot(0.41, half, CssCurves.easeIn),
        KeyframeDot(0.44, q1, CssCurves.easeIn),
        KeyframeDot(0.47, DotState.inactive, Curves.linear),
        KeyframeDot(0.61, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(0.64, q1, CssCurves.easeOut),
        KeyframeDot(0.67, half, CssCurves.easeOut),
        KeyframeDot(0.70, q3, CssCurves.easeOut),
        KeyframeDot(0.73, DotState.active, Curves.linear),
        KeyframeDot(0.85, DotState.active, CssCurves.easeIn),
        KeyframeDot(0.88, q3, CssCurves.easeIn),
        KeyframeDot(0.91, half, CssCurves.easeIn),
        KeyframeDot(0.94, q1, CssCurves.easeIn),
        KeyframeDot(0.97, DotState.inactive, Curves.linear),
        KeyframeDot(1.00, DotState.inactive),
      ];
    }

    return [
      evaluateKeyframes(progress, layer2Pattern()), // 0 - Top left (corner)
      evaluateKeyframes(progress, layer1Pattern()), // 1 - Top middle (cross)
      evaluateKeyframes(progress, layer2Pattern()), // 2 - Top right (corner)
      evaluateKeyframes(progress, layer1Pattern()), // 3 - Left middle (cross)
      evaluateKeyframes(progress, centerPattern), // 4 - Center (always lit)
      evaluateKeyframes(progress, layer1Pattern()), // 5 - Right middle (cross)
      evaluateKeyframes(progress, layer2Pattern()), // 6 - Bottom left (corner)
      evaluateKeyframes(progress, layer1Pattern()), // 7 - Bottom middle (cross)
      evaluateKeyframes(progress, layer2Pattern()), // 8 - Bottom right (corner)
    ];
  }
}
