import 'package:flutter/material.dart';

/// Standard easing curves for smooth animations
///
/// Provides ease-in, ease-out, and ease-in-out cubic bezier curves
class CssCurves {
  /// Ease-in curve: cubic-bezier(0.42, 0, 1.0, 1.0)
  static const easeIn = Cubic(0.42, 0.0, 1.0, 1.0);

  /// Ease-out curve: cubic-bezier(0, 0, 0.58, 1.0)
  static const easeOut = Cubic(0.0, 0.0, 0.58, 1.0);

  /// Ease-in-out curve: cubic-bezier(0.42, 0, 0.58, 1.0)
  static const easeInOut = Cubic(0.42, 0.0, 0.58, 1.0);
}

/// Calculate glow color with enhanced brightness
///
/// Uses a lighter version of the active color for glow effect
/// Example: rgba(255, 20, 204, 1) → rgba(255, 163, 235, 1)
/// Meaning: increase brightness to 70-90%, maintain high saturation
Color _computeGlowColor(Color baseColor) {
  final hsl = HSLColor.fromColor(baseColor);
  // Increase brightness to 80-92%, maintain saturation
  final glowHsl = hsl.withLightness((hsl.lightness + 0.4).clamp(0.8, 0.92));
  return glowHsl.toColor();
}

/// HSL color interpolation helper function
///
/// Interpolation in HSL color space is more natural than RGB, conforming to human visual perception
Color colorLerpHsl(Color a, Color b, double t) {
  // Convert to HSL
  final hslA = HSLColor.fromColor(a);
  final hslB = HSLColor.fromColor(b);

  // Interpolate (hue needs special handling for shortest path)
  final hueA = hslA.hue;
  final hueB = hslB.hue;
  final hueDiff = (hueB - hueA + 540) % 360 - 180;
  final hue = (hueA + hueDiff * t + 360) % 360;

  // Use with methods to create new HSLColor
  final hsl = hslA
      .withHue(hue)
      .withSaturation(hslA.saturation + (hslB.saturation - hslA.saturation) * t)
      .withLightness(hslA.lightness + (hslB.lightness - hslA.lightness) * t);

  return hsl.toColor();
}

/// Complete state of a dot
class DotState {
  final double opacity; // 0.0-1.0
  final double scale; // 1.0-1.1

  const DotState({this.opacity = 0.0, this.scale = 1.0});

  /// Inactive state
  static const inactive = DotState(opacity: 0.0, scale: 1.0);

  /// Fully active state (scale: 1.1)
  static const active = DotState(opacity: 1.0, scale: 1.1);

  /// Linear interpolation
  static DotState lerp(DotState a, DotState b, double t) {
    return DotState(
      opacity: a.opacity + (b.opacity - a.opacity) * t,
      scale: a.scale + (b.scale - a.scale) * t,
    );
  }
}

/// Dot matrix indicator base class
///
/// Contains all common parameters and rendering logic, subclasses only need to implement animation algorithm
abstract class DotIndicator extends StatefulWidget {
  /// Dot size (pixels)
  final double dotSize;

  /// Border radius (pixels)
  final double borderRadius;

  /// Dot spacing (pixels)
  final double spacing;

  /// Active dot color (uses theme color if not specified)
  final Color? activeColor;

  /// Inactive dot color (uses theme color if not specified)
  final Color? inactiveColor;

  /// Opacity (0.0-1.0)
  final double opacity;

  /// Shadow color (uses semi-transparent version of active color if not specified)
  final Color? shadowColor;

  /// Shadow offset (defaults to Offset.zero, i.e., in-place glow)
  final Offset shadowOffset;

  /// Shadow blur radius (pixels, defaults to 10px)
  final double blurRadius;

  /// Shadow spread radius (pixels, positive value expands, negative shrinks)
  final double spreadRadius;

  /// Animation cycle duration
  final Duration animationSpeed;

  /// Scale ratio (1.0 for no scaling, 1.1 for 10% enlargement)
  final double scale;

  /// Scale alignment (determines center position when dot scales)
  final Alignment scaleAlignment;

  const DotIndicator({
    super.key,
    this.dotSize = 8.0,
    this.borderRadius = 0.0,
    this.spacing = 0.0,
    this.activeColor,
    this.inactiveColor,
    this.opacity = 1.0,
    this.shadowColor,
    this.shadowOffset = Offset.zero,
    this.blurRadius = 10.0,
    this.spreadRadius = 0.0,
    this.animationSpeed = const Duration(milliseconds: 1000),
    this.scale = 1.1,
    this.scaleAlignment = Alignment.center,
  });

  /// Calculate activation states of each dot (including opacity and scale)
  ///
  /// [progress] Animation progress (0.0-1.0)
  /// Returns states of 9 dots (opacity, scale)
  List<DotState> calculateDotStates(double progress);

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

/// Keyframe record
class KeyframeDot {
  final double position;
  final DotState state;
  final Curve curve;

  const KeyframeDot(this.position, this.state, [this.curve = Curves.linear]);
}

/// Evaluate keyframe sequence
///
/// [progress] Current progress (0.0-1.0)
/// [keyframes] Keyframe sequence, must be sorted by position
///
/// Timing function is defined on the FROM keyframe,
/// controlling the transition from that keyframe to the next.
///
/// Returns interpolated state
DotState evaluateKeyframes(double progress, List<KeyframeDot> keyframes) {
  // Find the interval where progress resides
  for (int i = 0; i < keyframes.length - 1; i++) {
    final start = keyframes[i];
    final end = keyframes[i + 1];

    if (progress >= start.position && progress <= end.position) {
      // Within this interval, calculate weight and apply easing
      final t = (progress - start.position) / (end.position - start.position);
      // Timing function is defined on FROM keyframe, controls transition to TO
      final curve = start.curve;
      final curvedT = curve.transform(t);
      return DotState.lerp(start.state, end.state, curvedT);
    }
  }

  // Out of range, return state of last keyframe
  return keyframes.last.state;
}

class _DotIndicatorState extends State<DotIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationSpeed,
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(DotIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationSpeed != widget.animationSpeed) {
      _controller.duration = widget.animationSpeed;
      // Reset animation for new duration to take effect
      _controller
        ..reset()
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme colors as defaults
    final theme = Theme.of(context);
    final defaultActiveColor = theme.colorScheme.primary;
    final defaultInactiveColor = theme.colorScheme.surfaceContainerHighest
        .withValues(alpha: 0.3);

    final activeColor = widget.activeColor ?? defaultActiveColor;

    // shadowColor defaults to lighter version of active color
    // Example: rgba(255, 163, 235, 1) corresponds to active color rgba(255, 20, 204, 1)
    // Meaning: increase brightness, maintain high saturation
    final defaultShadowColor =
        widget.shadowColor ?? _computeGlowColor(activeColor);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(
            (widget.dotSize + widget.spacing) * 3,
            (widget.dotSize + widget.spacing) * 3,
          ),
          painter: _DotMatrixPainter(
            dotStates: widget.calculateDotStates(_controller.value),
            config: _DotConfig(
              dotSize: widget.dotSize,
              borderRadius: widget.borderRadius,
              spacing: widget.spacing,
              activeColor: activeColor,
              inactiveColor: widget.inactiveColor ?? defaultInactiveColor,
              opacity: widget.opacity,
              shadowColor: defaultShadowColor,
              shadowOffset: widget.shadowOffset,
              blurRadius: widget.blurRadius,
              spreadRadius: widget.spreadRadius,
              scale: widget.scale,
              scaleAlignment: widget.scaleAlignment,
            ),
          ),
        );
      },
    );
  }
}

/// Dot configuration (internal use)
class _DotConfig {
  final double dotSize;
  final double borderRadius;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final double opacity;
  final Color shadowColor;
  final Offset shadowOffset;
  final double blurRadius;
  final double spreadRadius;
  final double scale;
  final Alignment scaleAlignment;

  _DotConfig({
    required this.dotSize,
    required this.borderRadius,
    required this.spacing,
    required this.activeColor,
    required this.inactiveColor,
    required this.opacity,
    required this.shadowColor,
    required this.shadowOffset,
    required this.blurRadius,
    required this.spreadRadius,
    required this.scale,
    required this.scaleAlignment,
  });
}

/// Dot matrix painter
class _DotMatrixPainter extends CustomPainter {
  final List<DotState> dotStates;
  final _DotConfig config;

  _DotMatrixPainter({required this.dotStates, required this.config})
    : assert(dotStates.length == 9);

  @override
  void paint(Canvas canvas, Size size) {
    final step = config.dotSize + config.spacing;

    for (int i = 0; i < 9; i++) {
      final row = i ~/ 3;
      final col = i % 3;
      final x = col * step;
      final y = row * step;

      final state = dotStates[i];
      _paintDot(canvas, Offset(x, y), state);
    }
  }

  void _paintDot(Canvas canvas, Offset offset, DotState state) {
    final opacity = state.opacity.clamp(0.0, 1.0);

    // Only apply scaling to active state (opacity > 0), inactive state keeps original
    final scale = opacity > 0.01 ? config.scale : 1.0;

    // Calculate scaled size
    final scaledSize = config.dotSize * scale;
    final sizeDelta = scaledSize - config.dotSize;

    // Calculate offset based on Alignment
    // Alignment definition: (-1,-1)=top-left, (0,0)=center, (1,1)=bottom-right
    // Normalized alignment point: (0,0)=top-left, (0.5,0.5)=center, (1,1)=bottom-right
    final alignX = (config.scaleAlignment.x + 1) / 2;
    final alignY = (config.scaleAlignment.y + 1) / 2;

    // Offset formula: offset = align * sizeDelta
    final offsetX = alignX * sizeDelta;
    final offsetY = alignY * sizeDelta;

    final rect = Rect.fromLTWH(
      offset.dx - offsetX,
      offset.dy - offsetY,
      scaledSize,
      scaledSize,
    );
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(config.borderRadius * scale),
    );

    // Draw shadow (only in active state)
    if (opacity > 0.01) {
      // Apply spreadRadius: spread radius expands/shrinks shadow
      final spreadSize = scaledSize + config.spreadRadius * 2 * scale;
      final spreadDelta = spreadSize - scaledSize;
      final spreadRect = Rect.fromLTWH(
        rect.left - spreadDelta / 2,
        rect.top - spreadDelta / 2,
        spreadSize,
        spreadSize,
      );
      final spreadRRect = RRect.fromRectAndRadius(
        spreadRect,
        Radius.circular(
          (config.borderRadius * scale + config.spreadRadius * scale).clamp(
            0,
            double.infinity,
          ),
        ),
      );

      // Apply shadowOffset: shadow position offset
      final shadowPaint = Paint()
        ..color = config.shadowColor.withValues(alpha: opacity * config.opacity)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          config.blurRadius * scale,
        );

      canvas.drawRRect(
        spreadRRect.shift(config.shadowOffset * scale),
        shadowPaint,
      );
    }

    // Draw dot - color smoothly interpolates between keyframes
    // Use HSL color space interpolation, more natural to human visual perception than RGB
    final dotColor = colorLerpHsl(
      config.inactiveColor,
      config.activeColor,
      opacity,
    );
    final dotPaint = Paint()
      ..color = dotColor.withValues(alpha: config.opacity)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, dotPaint);
  }

  @override
  bool shouldRepaint(_DotMatrixPainter oldDelegate) {
    return oldDelegate.dotStates != dotStates || oldDelegate.config != config;
  }
}
