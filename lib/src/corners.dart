import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Corners - Four corners dot matrix indicator
///
/// Sequential lighting effect across the four corners. Only the corner
/// dots activate in sequence, creating a minimalist corner-to-corner animation.
///
/// **Example:**
/// ```dart
/// Corners(
///   dotSize: 14,
///   activeColor: Colors.indigo,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
///
/// Duration: 1750ms
/// Sequential corner activation
class Corners extends DotIndicator {
  const Corners({
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
    super.animationSpeed = const Duration(milliseconds: 1750),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // dot-1: 0% active → 34.29% ease-out → 68.57% inactive → 91.43% ease-in → 100% active
    // dot-3: 0% ease-in → 8.57% active → 42.86% ease-out → 77.14% inactive
    // dot-7: 11.43% ease-in → 20% active → 54.29% ease-out → 88.57% inactive
    // dot-9: 22.86% ease-in → 31.43% active → 65.71% ease-out → 100% inactive

    return [
      // dot-0: Top left corner - 0% activation starts, cross-cycle loop
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, Curves.linear),
        KeyframeDot(0.1143, DotState.active, Curves.linear),
        KeyframeDot(0.2286, DotState.active, Curves.linear),
        KeyframeDot(0.3429, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6857, DotState.inactive, Curves.linear),
        KeyframeDot(0.8000, DotState.inactive, Curves.linear),
        KeyframeDot(0.9143, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-1: Top middle - always inactive
      DotState.inactive,
      // dot-2: Top right corner - 0% ease-in → 8.57% active → 42.86% ease-out → 77.14% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0857, DotState.active, Curves.linear),
        KeyframeDot(0.2000, DotState.active, Curves.linear),
        KeyframeDot(0.3143, DotState.active, Curves.linear),
        KeyframeDot(0.4286, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7714, DotState.inactive, Curves.linear),
        KeyframeDot(0.8857, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-3: Left middle - always inactive
      DotState.inactive,
      // dot-4: Center - always inactive
      DotState.inactive,
      // dot-5: Right middle - always inactive
      DotState.inactive,
      // dot-6: Bottom left corner - 11.43% ease-in → 20% active → 54.29% ease-out → 88.57% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1143, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2000, DotState.active, Curves.linear),
        KeyframeDot(0.3143, DotState.active, Curves.linear),
        KeyframeDot(0.4286, DotState.active, Curves.linear),
        KeyframeDot(0.5429, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8857, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-7: Bottom middle - always inactive
      DotState.inactive,
      // dot-8: Bottom right corner - 22.86% ease-in → 31.43% active → 65.71% ease-out → 100% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1143, DotState.inactive, Curves.linear),
        KeyframeDot(0.2286, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.3143, DotState.active, Curves.linear),
        KeyframeDot(0.4286, DotState.active, Curves.linear),
        KeyframeDot(0.5429, DotState.active, Curves.linear),
        KeyframeDot(0.6571, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
    ];
  }
}
