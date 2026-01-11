import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Zigzag - Zigzag dot matrix indicator
///
/// Snake-like zigzag path scanning. First row left-to-right, second row
/// right-to-left, third row left-to-right.
///
/// **Example:**
/// ```dart
/// Zigzag(
///   dotSize: 12,
///   activeColor: Colors.lime,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class Zigzag extends DotIndicator {
  const Zigzag({
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
    // Zigzag path, 9 dots activate sequentially
    // First row: Left -> Right (dot-0 -> dot-1 -> dot-2)
    // Second row: Right -> Left (dot-5 -> dot-4 -> dot-3)
    // Third row: Left -> Right (dot-6 -> dot-7 -> dot-8)
    // Seamless loop

    // Progressive states
    const q1 = DotState(opacity: 0.25, scale: 1.025);
    const half = DotState(opacity: 0.5, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Each dot activation window is about 10%, total 9 dots
    List<KeyframeDot> makePattern(int order) {
      final start = order * 0.10;

      if (order == 0) {
        // First dot: Cross-cycle loop
        return [
          KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
          KeyframeDot(0.06, DotState.active, CssCurves.easeIn),
          KeyframeDot(0.08, q3, CssCurves.easeIn),
          KeyframeDot(0.10, half, CssCurves.easeIn),
          KeyframeDot(0.12, q1, CssCurves.easeIn),
          KeyframeDot(0.14, DotState.inactive, Curves.linear),
          KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
          KeyframeDot(0.94, q1, CssCurves.easeOut),
          KeyframeDot(0.96, half, CssCurves.easeOut),
          KeyframeDot(0.98, q3, CssCurves.easeOut),
          KeyframeDot(1.00, DotState.active),
        ];
      }

      return [
        KeyframeDot(0.00, DotState.inactive, Curves.linear),
        KeyframeDot(start - 0.04, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(start - 0.03, q1, CssCurves.easeOut),
        KeyframeDot(start - 0.02, half, CssCurves.easeOut),
        KeyframeDot(start - 0.01, q3, CssCurves.easeOut),
        KeyframeDot(start, DotState.active, Curves.linear),
        KeyframeDot(start + 0.06, DotState.active, CssCurves.easeIn),
        KeyframeDot(start + 0.08, q3, CssCurves.easeIn),
        KeyframeDot(start + 0.10, half, CssCurves.easeIn),
        KeyframeDot(start + 0.12, q1, CssCurves.easeIn),
        KeyframeDot(start + 0.14, DotState.inactive, Curves.linear),
        KeyframeDot(1.00, DotState.inactive),
      ];
    }

    return [
      evaluateKeyframes(progress, makePattern(0)), // dot-0: Top left (1st)
      evaluateKeyframes(progress, makePattern(1)), // dot-1: Top middle (2nd)
      evaluateKeyframes(progress, makePattern(2)), // dot-2: Top right (3rd)
      evaluateKeyframes(
        progress,
        makePattern(5),
      ), // dot-3: Middle left (6th, second row last)
      evaluateKeyframes(
        progress,
        makePattern(4),
      ), // dot-4: Center (5th, second row middle)
      evaluateKeyframes(
        progress,
        makePattern(3),
      ), // dot-5: Middle right (4th, second row first)
      evaluateKeyframes(progress, makePattern(6)), // dot-6: Bottom left (7th)
      evaluateKeyframes(progress, makePattern(7)), // dot-7: Bottom middle (8th)
      evaluateKeyframes(progress, makePattern(8)), // dot-8: Bottom right (9th)
    ];
  }
}
