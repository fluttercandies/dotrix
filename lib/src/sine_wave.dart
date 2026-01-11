import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// SineWave - Sine wave dot matrix indicator
///
/// Smooth sine wave propagation effect across the dot matrix,
/// creating organic flowing motion.
///
/// **Example:**
/// ```dart
/// SineWave(
///   dotSize: 12,
///   activeColor: Colors.lightBlue,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
///
/// Duration: 1150ms
/// Sine wave propagation
class SineWave extends DotIndicator {
  const SineWave({
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
    super.animationSpeed = const Duration(milliseconds: 1150),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Each dot has unique timing pattern

    return [
      // dot-0: 34.78% ease-in → 47.83% active → ease-out → 100% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1739, DotState.inactive, Curves.linear),
        KeyframeDot(0.3478, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4783, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-1: 0% active → ease-out → 52.17% inactive → 86.96% ease-in → 100% active
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5217, DotState.inactive, Curves.linear),
        KeyframeDot(0.6957, DotState.inactive, Curves.linear),
        KeyframeDot(0.8696, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-2: 0% ease-in → 13.04% active → ease-out → 65.22% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1304, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6522, DotState.inactive, Curves.linear),
        KeyframeDot(0.8261, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-3: 0% active → ease-out → 40% inactive → ease-in → 50% active → ease-out → 90% inactive → ease-in → 100% active
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.9000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-4: 0% ease-in → 10% active → ease-out → 50% inactive → ease-in → 60% active → ease-out → 100% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6000, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-5: Same as dot-3
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.9000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-6: Same as dot-2
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1304, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6522, DotState.inactive, Curves.linear),
        KeyframeDot(0.8261, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-7: 17.39% ease-in → 30.43% active → ease-out → 82.61% inactive
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1739, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.3043, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8261, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-8: Same as dot-0
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1739, DotState.inactive, Curves.linear),
        KeyframeDot(0.3478, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4783, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
    ];
  }
}
