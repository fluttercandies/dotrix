import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Cascade - Cascading dot matrix indicator
///
/// Waterfall flow effect with each column having an independent falling
/// phase, creating a continuous ripple-like waterfall animation.
///
/// **Example:**
/// ```dart
/// Cascade(
///   dotSize: 10,
///   activeColor: Colors.blue,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class Cascade extends DotIndicator {
  const Cascade({
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
    const half = DotState(opacity: 0.6, scale: 1.05);
    const q3 = DotState(opacity: 0.85, scale: 1.08);

    // Waterfall flow: each column has different falling phase, each dot lights up sequentially forming falling effect
    // Left column phase=0, middle column phase=0.15, right column phase=0.30
    // Within each column: first row → second row → third row light up sequentially

    List<KeyframeDot> makePattern(int col, int row) {
      // col: 0=left, 1=middle, 2=right
      // row: 0=top, 1=middle, 2=bottom
      final colPhase = col * 0.12; // Phase difference between columns
      final rowDelay = row * 0.18; // Delay between rows
      final start = (colPhase + rowDelay) % 1.0;

      // First activated dot needs cross-cycle loop
      if (col == 0 && row == 0) {
        return [
          KeyframeDot(0.00, DotState.active, CssCurves.easeOut),
          KeyframeDot(0.08, DotState.active, CssCurves.easeIn),
          KeyframeDot(0.10, q3, CssCurves.easeIn),
          KeyframeDot(0.12, half, CssCurves.easeIn),
          KeyframeDot(0.14, q1, CssCurves.easeIn),
          KeyframeDot(0.16, DotState.inactive, Curves.linear),
          KeyframeDot(0.92, DotState.inactive, CssCurves.easeOut),
          KeyframeDot(0.94, q1, CssCurves.easeOut),
          KeyframeDot(0.96, half, CssCurves.easeOut),
          KeyframeDot(0.98, q3, CssCurves.easeOut),
          KeyframeDot(1.00, DotState.active),
        ];
      }

      // Handle cross-cycle situation
      if (start > 0.85) {
        final wrapStart = start;
        final wrapEnd = (start + 0.16) % 1.0;
        return [
          KeyframeDot(0.00, q3, CssCurves.easeOut),
          KeyframeDot(wrapEnd * 0.3, DotState.active, Curves.linear),
          KeyframeDot(wrapEnd * 0.5, DotState.active, CssCurves.easeIn),
          KeyframeDot(wrapEnd * 0.6, q3, CssCurves.easeIn),
          KeyframeDot(wrapEnd * 0.7, half, CssCurves.easeIn),
          KeyframeDot(wrapEnd * 0.85, q1, CssCurves.easeIn),
          KeyframeDot(wrapEnd, DotState.inactive, Curves.linear),
          KeyframeDot(wrapStart - 0.04, DotState.inactive, CssCurves.easeOut),
          KeyframeDot(wrapStart - 0.03, q1, CssCurves.easeOut),
          KeyframeDot(wrapStart - 0.02, half, CssCurves.easeOut),
          KeyframeDot(wrapStart - 0.01, q3, CssCurves.easeOut),
          KeyframeDot(wrapStart, DotState.active, Curves.linear),
          KeyframeDot(1.00, q3),
        ];
      }

      return [
        KeyframeDot(0.00, DotState.inactive, Curves.linear),
        KeyframeDot(start - 0.04, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(start - 0.03, q1, CssCurves.easeOut),
        KeyframeDot(start - 0.02, half, CssCurves.easeOut),
        KeyframeDot(start - 0.01, q3, CssCurves.easeOut),
        KeyframeDot(start, DotState.active, Curves.linear),
        KeyframeDot(start + 0.08, DotState.active, CssCurves.easeIn),
        KeyframeDot(start + 0.10, q3, CssCurves.easeIn),
        KeyframeDot(start + 0.12, half, CssCurves.easeIn),
        KeyframeDot(start + 0.14, q1, CssCurves.easeIn),
        KeyframeDot(start + 0.16, DotState.inactive, Curves.linear),
        KeyframeDot(1.00, DotState.inactive),
      ];
    }

    return [
      evaluateKeyframes(progress, makePattern(0, 0)), // 0 - Top left
      evaluateKeyframes(progress, makePattern(1, 0)), // 1 - Top middle
      evaluateKeyframes(progress, makePattern(2, 0)), // 2 - Top right
      evaluateKeyframes(progress, makePattern(0, 1)), // 3 - Left middle
      evaluateKeyframes(progress, makePattern(1, 1)), // 4 - Center
      evaluateKeyframes(progress, makePattern(2, 1)), // 5 - Right middle
      evaluateKeyframes(progress, makePattern(0, 2)), // 6 - Bottom left
      evaluateKeyframes(progress, makePattern(1, 2)), // 7 - Bottom middle
      evaluateKeyframes(progress, makePattern(2, 2)), // 8 - Bottom right
    ];
  }
}
