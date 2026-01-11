import 'dart:math';

import 'package:flutter/material.dart';

import 'dot_indicator.dart';

/// FlowDown - Downward flowing dot matrix indicator
///
/// Three independent waterfall columns flowing from top to bottom.
/// Each column has a slightly different phase and speed.
///
/// **Example:**
/// ```dart
/// FlowDown(
///   dotSize: 12,
///   activeColor: Colors.lightGreen,
///   animationSpeed: Duration(milliseconds: 2000),
/// )
/// ```
class FlowDown extends DotIndicator {
  final double col0Phase;
  final double col1Phase;
  final double col2Phase;
  final double col0Speed;
  final double col1Speed;
  final double col2Speed;

  const FlowDown({
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
    this.col0Phase = 0.0,
    this.col1Phase = 0.22,
    this.col2Phase = 0.44,
    this.col0Speed = 1.0,
    this.col1Speed = 1.08,
    this.col2Speed = 0.92,
  });

  factory FlowDown.random({
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
    return FlowDown(
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
      col0Phase: random.nextDouble(),
      col1Phase: random.nextDouble(),
      col2Phase: random.nextDouble(),
      col0Speed: 0.88 + random.nextDouble() * 0.24,
      col1Speed: 0.88 + random.nextDouble() * 0.24,
      col2Speed: 0.88 + random.nextDouble() * 0.24,
    );
  }

  @override
  List<DotState> calculateDotStates(double progress) {
    // Left column
    final col0Progress = (progress * col0Speed + col0Phase) % 1.0;
    final col0States = _calculateColumn(col0Progress);

    // Center column (delayed)
    final col1Progress = (progress * col1Speed + col1Phase) % 1.0;
    final col1States = _calculateColumn(col1Progress);

    // Right column (more delayed)
    final col2Progress = (progress * col2Speed + col2Phase) % 1.0;
    final col2States = _calculateColumn(col2Progress);

    return [
      col0States[0], col1States[0], col2States[0], // Top row
      col0States[1], col1States[1], col2States[1], // Middle row
      col0States[2], col1States[2], col2States[2], // Bottom row
    ];
  }

  /// Calculate the state of three dots in a column
  /// Downward flow: Two light beams enter from top, move down, exit from bottom
  List<DotState> _calculateColumn(double p) {
    // Dot positions: top=0, middle=0.5, bottom=1.0
    // Light beam moves from top (-0.25) to bottom (1.25)

    final beam1 = -0.25 + p * 1.5;
    final beam2 = beam1 - 1.5;

    final op0 = max(_beamBrightness(0.0, beam1), _beamBrightness(0.0, beam2));
    final op3 = max(_beamBrightness(0.5, beam1), _beamBrightness(0.5, beam2));
    final op6 = max(_beamBrightness(1.0, beam1), _beamBrightness(1.0, beam2));

    return [
      DotState(opacity: op0, scale: 1.0 + op0 * 0.1),
      DotState(opacity: op3, scale: 1.0 + op3 * 0.1),
      DotState(opacity: op6, scale: 1.0 + op6 * 0.1),
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
