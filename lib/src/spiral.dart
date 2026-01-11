import 'package:flutter/material.dart';
import 'dot_indicator.dart';

/// Spiral - Spiral dot matrix indicator
///
/// Spiral expansion from center to outer edges, creating a vortex effect.
/// Dots activate in a clockwise spiral pattern from center outward:
/// center → top → top-right → right → bottom-right → bottom →
/// bottom-left → left → top-left.
///
/// **Example:**
/// ```dart
/// // Basic usage
/// Spiral()
///
/// // Customized
/// Spiral(
///   dotSize: 16,
///   spacing: 6,
///   activeColor: Colors.purple,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
///
/// Duration: 1500ms
/// Clockwise spiral expansion from center
class Spiral extends DotIndicator {
  const Spiral({
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
    super.animationSpeed = const Duration(milliseconds: 1500),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
  });

  @override
  List<DotState> calculateDotStates(double progress) {
    // Spiral path: Clockwise expansion from center
    // dot-4(center) -> dot-1(top) -> dot-2(top right) ->
    // dot-5(right) -> dot-8(bottom right) -> dot-7(bottom) ->
    // dot-6(bottom left) -> dot-3(left) -> dot-0(top left)
    // Each dot lights up sequentially, forming spiral flow effect

    // Progressive states
    const q1 = DotState(opacity: 0.25, scale: 1.025);
    const half = DotState(opacity: 0.5, scale: 1.05);
    const q3 = DotState(opacity: 0.8, scale: 1.08);

    // Each dot's activation window occupies 10%, total 9 dots = 90%, leaving 10% blank to form pulse intervals
    List<KeyframeDot> makePattern(int order) {
      final start = order * 0.10; // 10% interval between dots
      final fadeIn = start;
      final peak = start + 0.05;
      final fadeOut = start + 0.15;

      if (order == 0) {
        // First dot (center): Cross-cycle loop
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

      return [
        KeyframeDot(0.00, DotState.inactive, Curves.linear),
        KeyframeDot(fadeIn - 0.04, DotState.inactive, CssCurves.easeOut),
        KeyframeDot(fadeIn - 0.03, q1, CssCurves.easeOut),
        KeyframeDot(fadeIn - 0.02, half, CssCurves.easeOut),
        KeyframeDot(fadeIn - 0.01, q3, CssCurves.easeOut),
        KeyframeDot(fadeIn, DotState.active, Curves.linear),
        KeyframeDot(peak, DotState.active, CssCurves.easeIn),
        KeyframeDot(peak + 0.02, q3, CssCurves.easeIn),
        KeyframeDot(peak + 0.04, half, CssCurves.easeIn),
        KeyframeDot(peak + 0.06, q1, CssCurves.easeIn),
        KeyframeDot(fadeOut, DotState.inactive, Curves.linear),
        KeyframeDot(1.00, DotState.inactive),
      ];
    }

    return [
      evaluateKeyframes(
        progress,
        makePattern(8),
      ), // dot-0: Top left (order 8, last)
      evaluateKeyframes(progress, makePattern(1)), // dot-1: Top (order 1)
      evaluateKeyframes(progress, makePattern(2)), // dot-2: Top right (order 2)
      evaluateKeyframes(progress, makePattern(7)), // dot-3: Left (order 7)
      evaluateKeyframes(
        progress,
        makePattern(0),
      ), // dot-4: Center (order 0, start)
      evaluateKeyframes(progress, makePattern(3)), // dot-5: Right (order 3)
      evaluateKeyframes(
        progress,
        makePattern(6),
      ), // dot-6: Bottom left (order 6)
      evaluateKeyframes(progress, makePattern(5)), // dot-7: Bottom (order 5)
      evaluateKeyframes(
        progress,
        makePattern(4),
      ), // dot-8: Bottom right (order 4)
    ];
  }
}
