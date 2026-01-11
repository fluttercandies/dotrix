/// Dotrix - Dot matrix animation indicator component library
///
/// Provides various dot matrix animation effects, each effect is an independent component with complete parameters
///
/// ## Usage Example
/// ```dart
/// // Simple usage
/// Pulse(
///   dotSize: 36,
///   activeColor: Color(0xFFFF14CC),
/// )
///
/// // Parameters supported by all components:
/// // - dotSize: Dot size
/// // - borderRadius: Border radius
/// // - spacing: Dot spacing
/// // - activeColor: Active color
/// // - inactiveColor: Inactive color
/// // - opacity: Opacity
/// // - glowColor: Glow color
/// // - glowOpacity: Glow opacity
/// // - glowSpread: Glow spread
/// // - animationSpeed: Animation speed
/// ```
library;

// Basic components
export 'src/pulse.dart';
export 'src/spinner.dart';
export 'src/wave.dart';

// Extended components
export 'src/arrow_move.dart';
export 'src/burst.dart';
export 'src/chaos.dart';
export 'src/clockwise.dart';
export 'src/corners.dart';
export 'src/cross.dart';
export 'src/diamond.dart';
export 'src/pulse2.dart';
export 'src/sine_wave.dart';

// New components
export 'src/spiral.dart';
export 'src/zigzag.dart';
export 'src/radial.dart';
export 'src/cascade.dart';
export 'src/inward.dart';
export 'src/ripple.dart';
export 'src/checkerboard.dart';
export 'src/converge.dart';
export 'src/scatter.dart';
export 'src/flip.dart';
export 'src/pulse_ring.dart';
export 'src/diagonal_race.dart';

// Flow components
export 'src/flow_up.dart';
export 'src/flow_down.dart';
export 'src/flow_left.dart';
export 'src/flow_right.dart';
