import 'dart:math';

import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// FlowLeft - Leftward flowing dot matrix indicator
///
/// Three independent waterfall rows flowing from right to left.
/// Each row has a slightly different phase and speed.
///
/// **Example:**
/// ```dart
/// FlowLeft(
///   dotSize: 10,
///   activeColor: Colors.lightBlue,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class FlowLeft extends DotIndicator {
  final double row0Phase;
  final double row1Phase;
  final double row2Phase;
  final double row0Speed;
  final double row1Speed;
  final double row2Speed;

  const FlowLeft({
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
    super.animationSpeed = const Duration(milliseconds: 1800),
    super.scale = 1.1,
    super.scaleAlignment = Alignment.center,
    this.row0Phase = 0.0,
    this.row1Phase = 0.22,
    this.row2Phase = 0.44,
    this.row0Speed = 1.0,
    this.row1Speed = 1.08,
    this.row2Speed = 0.92,
  });

  factory FlowLeft.random({
    Key? key,
    double dotSize = 8.0,
    double borderRadius = 0.0,
    double spacing = 0.0,
    Color? activeColor,
    Color? inactiveColor,
    double opacity = 1.0,
    Color? shadowColor,
    double blurRadius = 10.0,
    Offset shadowOffset = Offset.zero,
    double spreadRadius = 0.0,
    Duration animationSpeed = const Duration(milliseconds: 1800),
    double scale = 1.1,
    Alignment scaleAlignment = Alignment.center,
  }) {
    final random = Random();
    return FlowLeft(
      key: key,
      dotSize: dotSize,
      borderRadius: borderRadius,
      spacing: spacing,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      opacity: opacity,
      shadowColor: shadowColor,
      blurRadius: blurRadius,
      shadowOffset: shadowOffset,
      spreadRadius: spreadRadius,
      animationSpeed: animationSpeed,
      scale: scale,
      scaleAlignment: scaleAlignment,
      row0Phase: random.nextDouble(),
      row1Phase: random.nextDouble(),
      row2Phase: random.nextDouble(),
      row0Speed: 0.88 + random.nextDouble() * 0.24,
      row1Speed: 0.88 + random.nextDouble() * 0.24,
      row2Speed: 0.88 + random.nextDouble() * 0.24,
    );
  }

  @override
  List<DotState> calculateDotStates(double progress) {
    // Top row
    final row0Progress = (progress * row0Speed + row0Phase) % 1.0;
    final row0States = _calculateRow(row0Progress);

    // Middle row (delayed)
    final row1Progress = (progress * row1Speed + row1Phase) % 1.0;
    final row1States = _calculateRow(row1Progress);

    // Bottom row (more delayed)
    final row2Progress = (progress * row2Speed + row2Phase) % 1.0;
    final row2States = _calculateRow(row2Progress);

    return [
      row0States[0], row0States[1], row0States[2], // Top row
      row1States[0], row1States[1], row1States[2], // Middle row
      row2States[0], row2States[1], row2States[2], // Bottom row
    ];
  }

  /// Calculate the state of three dots in a row
  /// Leftward flow: Two light beams enter from right, move left, exit from left
  List<DotState> _calculateRow(double p) {
    // Dot positions: left=0, middle=0.5, right=1.0
    // Light beam moves from right (1.25) to left (-0.25)

    final beam1 = 1.25 - p * 1.5;
    final beam2 = beam1 + 1.5;

    final opL = max(_beamBrightness(0.0, beam1), _beamBrightness(0.0, beam2));
    final opM = max(_beamBrightness(0.5, beam1), _beamBrightness(0.5, beam2));
    final opR = max(_beamBrightness(1.0, beam1), _beamBrightness(1.0, beam2));

    return [
      DotState(opacity: opL, scale: 1.0 + opL * 0.1),
      DotState(opacity: opM, scale: 1.0 + opM * 0.1),
      DotState(opacity: opR, scale: 1.0 + opR * 0.1),
    ];
  }

  double _beamBrightness(double dotPos, double beamHead) {
    const beamLen = 0.55;
    final beamTail = beamHead - beamLen;

    if (dotPos < beamTail || dotPos > beamHead) return 0.0;

    final center = (beamHead + beamTail) / 2;
    final dist = (dotPos - center).abs();
    final halfLen = beamLen / 2;

    final t = dist / halfLen;
    return 0.5 * (1.0 + cos(pi * t));
  }
}
