import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Chaos - Chaos dot matrix indicator
///
/// Each dot flickers with a unique random pattern, creating a chaotic
/// sparkle effect. Perfect for playful or animated loading states.
///
/// **Example:**
/// ```dart
/// Chaos(
///   dotSize: 8,
///   activeColor: Colors.yellow,
///   animationSpeed: Duration(milliseconds: 5000),
/// )
/// ```
///
/// Duration: 3750ms
/// Random flicker pattern for each dot
class Chaos extends DotIndicator {
  const Chaos({
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
    super.animationSpeed = const Duration(milliseconds: 3750),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Each dot has unique flicker pattern
    return [
      // dot-0: 5 regular flickers
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.1600, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.3600, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5600, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7600, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.8000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.9600, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-1: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0492, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.2459, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2951, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4918, DotState.inactive, Curves.linear),
        KeyframeDot(0.5574, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6066, DotState.active, Curves.linear),
        KeyframeDot(0.6721, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8689, DotState.inactive, Curves.linear),
        KeyframeDot(0.9344, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-2: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.1967, DotState.inactive, Curves.linear),
        KeyframeDot(0.2623, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.3115, DotState.active, Curves.linear),
        KeyframeDot(0.3770, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.5738, DotState.inactive, Curves.linear),
        KeyframeDot(0.6393, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6885, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8852, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.9344, DotState.active, Curves.linear),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-3: 5 regular flickers (offset)
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0400, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.2000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2400, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4400, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.6400, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.8400, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-4: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.2222, DotState.inactive, Curves.linear),
        KeyframeDot(0.2963, DotState.inactive, Curves.linear),
        KeyframeDot(0.3704, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4259, DotState.active, Curves.linear),
        KeyframeDot(0.5000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7222, DotState.inactive, Curves.linear),
        KeyframeDot(0.7963, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.8519, DotState.active, Curves.linear),
        KeyframeDot(0.9259, DotState.active, Curves.linear),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-5: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0492, DotState.active, Curves.linear),
        KeyframeDot(0.1148, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.3115, DotState.inactive, Curves.linear),
        KeyframeDot(0.3770, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4262, DotState.active, Curves.linear),
        KeyframeDot(0.4918, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6885, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.7377, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.9344, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-6: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.1765, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.2206, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.3971, DotState.inactive, Curves.linear),
        KeyframeDot(0.4559, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5000, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6765, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.7206, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.8971, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.9412, DotState.active, Curves.linear),
        KeyframeDot(1.0000, DotState.active),
      ]),
      // dot-7: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.0492, DotState.active, Curves.linear),
        KeyframeDot(0.1148, DotState.active, Curves.linear),
        KeyframeDot(0.1803, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.3770, DotState.inactive, Curves.linear),
        KeyframeDot(0.4426, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.4918, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.6885, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.7377, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.9344, DotState.inactive, Curves.linear),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
      // dot-8: Irregular pattern
      evaluateKeyframes(progress, [
        KeyframeDot(0.0000, DotState.inactive, Curves.linear),
        KeyframeDot(0.0656, DotState.inactive, Curves.linear),
        KeyframeDot(0.1311, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.1803, DotState.active, Curves.linear),
        KeyframeDot(0.2459, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.4426, DotState.inactive, Curves.linear),
        KeyframeDot(0.5082, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.5574, DotState.active, CssCurves.easeOut),
        KeyframeDot(0.7541, DotState.inactive, CssCurves.easeIn),
        KeyframeDot(0.8033, DotState.active, CssCurves.easeOut),
        KeyframeDot(1.0000, DotState.inactive),
      ]),
    ];
  }
}
