import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// ArrowMove - Arrow movement dot matrix indicator
///
/// Arrow starts from top-left corner and splits into two paths spreading
/// downward, creating a synchronized arrow-flow animation.
///
/// **Example:**
/// ```dart
/// ArrowMove(
///   dotSize: 10,
///   activeColor: Colors.orange,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
///
/// Duration: 1550ms
/// Arrow path splits from top-left, flows downward
class ArrowMove extends DotIndicator {
  const ArrowMove({
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
    super.animationSpeed = const Duration(milliseconds: 1550),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // dot-1,7: 0% linear → 12.90% ease-in → 22.58% active ease-out → 61.29% inactive linear
    // dot-2,8: 0% linear → 25.81% ease-in → 35.48% active ease-out → 74.19% inactive linear
    // dot-3,9: 0% linear → 38.71% ease-in → 48.39% active ease-out → 87.10% inactive linear
    // dot-4: Dual activation 0% ease-in → 7.89% active, 39.47% ease-in → 47.37% active
    // dot-5: Dual activation 10.53% ease-in → 18.42% active, 50% ease-in → 57.89% active
    // dot-6: Dual activation 21.05% ease-in → 28.95% active, 60.53% ease-in → 68.42% active

    return [
      // dot-0: Single activation 12.90%-61.29%
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2258, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6129, DotState.inactive, Curves.linear),
        KeyframeDot(0.7419, DotState.inactive, Curves.linear),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-1: Single activation 25.81%-74.19%
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, Curves.linear),
        KeyframeDot(0.2581, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.3548, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7419, DotState.inactive, Curves.linear),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-2: Single activation 38.71%-87.10%
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, Curves.linear),
        KeyframeDot(0.2581, DotState.inactive, Curves.linear),
        KeyframeDot(0.3871, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4839, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-3: Dual activation
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0789, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.3947, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4737, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7895, DotState.inactive, Curves.linear),
        KeyframeDot(0.8947, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-4: Dual activation
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1053, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1842, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5789, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8947, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-5: Dual activation
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1053, DotState.inactive, Curves.linear),
        KeyframeDot(0.2105, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2895, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6053, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6842, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-6: Same as dot-0
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2258, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6129, DotState.inactive, Curves.linear),
        KeyframeDot(0.7419, DotState.inactive, Curves.linear),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-7: Same as dot-1
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, Curves.linear),
        KeyframeDot(0.2581, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.3548, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7419, DotState.inactive, Curves.linear),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-8: Same as dot-2
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.1290, DotState.inactive, Curves.linear),
        KeyframeDot(0.2581, DotState.inactive, Curves.linear),
        KeyframeDot(0.3871, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4839, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8710, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
    ];
  }
}
