import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// Clockwise - Clockwise rotating dot matrix indicator
///
/// Eight outer dots rotate clockwise sequentially, creating a smooth
/// rotating chase effect. The center dot remains inactive.
///
/// **Example:**
/// ```dart
/// Clockwise(
///   dotSize: 10,
///   activeColor: Colors.green,
///   animationSpeed: Duration(milliseconds: 1500),
/// )
/// ```
///
/// Duration: 1200ms
/// Clockwise rotation along outer ring
class Clockwise extends DotIndicator {
  const Clockwise({
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
    // 8 outer dots rotate clockwise, each dot has a phase difference of 1/8 = 12.5%
    // Order: dot-1(top middle) -> dot-2(top right) -> dot-5(right middle) -> dot-8(bottom right) ->
    //       dot-7(bottom middle) -> dot-6(bottom left) -> dot-3(left middle) -> dot-0(top left)

    // Progressive states
    const q1 = DotState(opacity: 0.25, scale: 1.025);
    const half = DotState(opacity: 0.5, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Generate keyframe pattern for each dot
    // phase: 0-7 indicates the phase in 8 positions
    List<KeyframeDot> makePattern(int phase) {
      final start = phase / 8.0;
      // Activation window: 20% of the cycle
      final peakEnd = (start + 0.15) % 1.0;
      final fadeEnd = (start + 0.25) % 1.0;

      // If crossing cycle boundary, special handling is needed
      if (start > 0.75) {
        // Cross cycle: need to activate at the beginning too
        return [
          KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
          KeyframeDot(peakEnd, DotState.active, CssCurves.easeIn),
          KeyframeDot((peakEnd + 0.03).clamp(0, 1), q3, CssCurves.easeIn),
          KeyframeDot((peakEnd + 0.06).clamp(0, 1), half, CssCurves.easeIn),
          KeyframeDot((peakEnd + 0.09).clamp(0, 1), q1, CssCurves.easeIn),
          KeyframeDot(fadeEnd, DotState.inactive, Curves.linear),
          KeyframeDot(start - 0.10, DotState.inactive, CssCurves.easeOut),
          KeyframeDot(start - 0.07, q1, CssCurves.easeOut),
          KeyframeDot(start - 0.04, half, CssCurves.easeOut),
          KeyframeDot(start - 0.01, q3, CssCurves.easeOut),
          KeyframeDot(start, DotState.active, Curves.linear),
          KeyframeDot(1.00, DotState.active),
        ];
      } else {
        return [
          KeyframeDot(0.00, DotState.inactive, Curves.linear),
          KeyframeDot(
            (start - 0.10).clamp(0, 1),
            DotState.inactive,
            CssCurves.easeOut,
          ),
          KeyframeDot((start - 0.07).clamp(0, 1), q1, CssCurves.easeOut),
          KeyframeDot((start - 0.04).clamp(0, 1), half, CssCurves.easeOut),
          KeyframeDot((start - 0.01).clamp(0, 1), q3, CssCurves.easeOut),
          KeyframeDot(start, DotState.active, Curves.linear),
          KeyframeDot(peakEnd, DotState.active, CssCurves.easeIn),
          KeyframeDot(peakEnd + 0.03, q3, CssCurves.easeIn),
          KeyframeDot(peakEnd + 0.06, half, CssCurves.easeIn),
          KeyframeDot(peakEnd + 0.09, q1, CssCurves.easeIn),
          KeyframeDot(fadeEnd, DotState.inactive, Curves.linear),
          KeyframeDot(1.00, DotState.inactive),
        ];
      }
    }

    return [
      evaluateKeyframes(progress, makePattern(7)), // dot-0: Top left (phase 7)
      evaluateKeyframes(
        progress,
        makePattern(0),
      ), // dot-1: Top middle (phase 0, start)
      evaluateKeyframes(progress, makePattern(1)), // dot-2: Top right (phase 1)
      evaluateKeyframes(
        progress,
        makePattern(6),
      ), // dot-3: Left middle (phase 6)
      DotState.inactive, // dot-4: Center - always inactive
      evaluateKeyframes(
        progress,
        makePattern(2),
      ), // dot-5: Right middle (phase 2)
      evaluateKeyframes(
        progress,
        makePattern(5),
      ), // dot-6: Bottom left (phase 5)
      evaluateKeyframes(
        progress,
        makePattern(4),
      ), // dot-7: Bottom middle (phase 4)
      evaluateKeyframes(
        progress,
        makePattern(3),
      ), // dot-8: Bottom right (phase 3)
    ];
  }
}
