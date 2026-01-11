import 'package:flutter/material.dart';
import 'package:dotrix/dotrix.dart';

void main() {
  runApp(const DotrixDemoApp());
}

class DotrixDemoApp extends StatelessWidget {
  const DotrixDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dotrix Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // Configuration parameters
  double dotSize = 36.0;
  double borderRadius = 0.0;
  double spacing = 0.0;
  int animationSpeed = 1200;
  Color activeColor = const Color(0xFFFFD700);
  Color inactiveColor = const Color(0xFF333333);
  double opacity = 1.0;
  Color shadowColor = const Color(0xFFFFE57F).withValues(alpha: 0.41);
  Offset shadowOffset = Offset.zero;
  double blurRadius = 11.0;
  double spreadRadius = 0.0;
  double scale = 1.0;
  Alignment scaleAlignment = Alignment.center;

  // All component types (alphabetically sorted)
  final List<({String name, Widget widget})> indicators = [
    (name: 'ArrowMove', widget: const ArrowMove()),
    (name: 'Burst', widget: const Burst()),
    (name: 'Cascade', widget: const Cascade()),
    (name: 'Chaos', widget: const Chaos()),
    (name: 'Checkerboard', widget: const Checkerboard()),
    (name: 'Clockwise', widget: const Clockwise()),
    (name: 'Converge', widget: const Converge()),
    (name: 'Corners', widget: const Corners()),
    (name: 'Cross', widget: const Cross()),
    (name: 'Diamond', widget: const Diamond()),
    (name: 'DiagonalRace', widget: const DiagonalRace()),
    (name: 'Flip', widget: const Flip()),
    (name: 'FlowDown', widget: FlowDown.random()),
    (name: 'FlowLeft', widget: FlowLeft.random()),
    (name: 'FlowRight', widget: FlowRight.random()),
    (name: 'FlowUp', widget: FlowUp.random()),
    (name: 'Inward', widget: const Inward()),
    (name: 'Pulse', widget: const Pulse()),
    (name: 'Pulse2', widget: const Pulse2()),
    (name: 'PulseRing', widget: const PulseRing()),
    (name: 'Radial', widget: const Radial()),
    (name: 'Ripple', widget: const Ripple()),
    (name: 'Scatter', widget: const Scatter()),
    (name: 'SineWave', widget: const SineWave()),
    (name: 'Spiral', widget: const Spiral()),
    (name: 'Spinner', widget: const Spinner()),
    (name: 'Wave', widget: const Wave()),
    (name: 'Zigzag', widget: const Zigzag()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left configuration panel
          Container(
            width: 320,
            color: const Color(0xFF0A0A0A),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Title
                const Text(
                  'Dotrix Configuration',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dot matrix animation indicator component library - 28 effects',
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
                const SizedBox(height: 32),

                // Size and spacing
                _buildSectionHeader('Size & Spacing'),
                _buildSlider('Dot Size', dotSize, 8, 64, (v) {
                  setState(() => dotSize = v);
                }, suffix: 'px'),
                _buildSlider('Border Radius', borderRadius, 0, 32, (v) {
                  setState(() => borderRadius = v);
                }, suffix: 'px'),
                _buildSlider('Spacing', spacing, 0, 16, (v) {
                  setState(() => spacing = v);
                }, suffix: 'px'),
                _buildSlider('Scale', scale * 100, 50, 150, (v) {
                  setState(() => scale = v / 100);
                }, suffix: '%'),
                _buildAlignmentSelector(),
                const SizedBox(height: 24),

                // Animation parameters
                _buildSectionHeader('Animation Parameters'),
                _buildSlider(
                  'Animation Speed',
                  animationSpeed.toDouble(),
                  200,
                  3000,
                  (v) {
                    setState(() => animationSpeed = v.round());
                  },
                  suffix: 'ms',
                ),
                const SizedBox(height: 24),

                // Color properties
                _buildSectionHeader('Color Properties'),
                _buildColorPicker('Active Color', activeColor, (color) {
                  setState(() => activeColor = color);
                }),
                _buildColorPicker('Inactive Color', inactiveColor, (color) {
                  setState(() => inactiveColor = color);
                }),
                _buildSlider('Opacity', opacity * 100, 0, 100, (v) {
                  setState(() => opacity = v / 100);
                }, suffix: '%'),
                const SizedBox(height: 24),

                // Shadow properties (BoxShadow specification)
                _buildSectionHeader('Shadow Properties'),
                _buildColorPicker('Shadow Color', shadowColor, (color) {
                  setState(() => shadowColor = color);
                }),
                _buildSlider('Blur Radius', blurRadius, 0, 30, (v) {
                  setState(() => blurRadius = v);
                }, suffix: 'px'),
                _buildSlider('Spread Radius', spreadRadius, -10, 20, (v) {
                  setState(() => spreadRadius = v);
                }, suffix: 'px'),
                _buildShadowOffsetSelector(),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Divider
          Container(width: 1, color: const Color(0xFF1A1A1A)),

          // Right component display
          Expanded(
            child: Container(
              color: const Color(0xFF050505),
              child: GridView.builder(
                padding: const EdgeInsets.all(32),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 160,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                ),
                itemCount: indicators.length,
                itemBuilder: (context, index) {
                  final indicator = indicators[index];
                  return _buildIndicatorCard(indicator.name, indicator.widget);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[400],
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged, {
    String suffix = '',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${value.round()}$suffix',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[400],
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: activeColor,
              inactiveTrackColor: const Color(0xFF1A1A1A),
              thumbColor: activeColor,
              overlayColor: activeColor.withValues(alpha: 0.2),
              valueIndicatorColor: activeColor,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(
    String label,
    Color color,
    ValueChanged<Color> onColorChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          debugPrint('🔍 Click color picker: $label');
          _showColorPicker(context, color, onColorChanged);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[400],
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignmentSelector() {
    final alignments = [
      (Alignment.topLeft, 'TopLeft'),
      (Alignment.topCenter, 'TopCenter'),
      (Alignment.topRight, 'TopRight'),
      (Alignment.centerLeft, 'CenterLeft'),
      (Alignment.center, 'Center'),
      (Alignment.centerRight, 'CenterRight'),
      (Alignment.bottomLeft, 'BottomLeft'),
      (Alignment.bottomCenter, 'BottomCenter'),
      (Alignment.bottomRight, 'BottomRight'),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scale Alignment',
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: alignments.map((alignment) {
              final isSelected = alignment.$1 == scaleAlignment;
              return InkWell(
                onTap: () {
                  setState(() => scaleAlignment = alignment.$1);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? activeColor : const Color(0xFF2A2A2A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    alignment.$2,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.black : Colors.grey[400],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShadowOffsetSelector() {
    final offsets = [
      (Offset(-4, -4), '↖ Top Left'),
      (Offset(0, -4), '↑ Top'),
      (Offset(4, -4), '↗ Top Right'),
      (Offset(-4, 0), '← Left'),
      (Offset.zero, '● No Offset'),
      (Offset(4, 0), '→ Right'),
      (Offset(-4, 4), '↙ Bottom Left'),
      (Offset(0, 4), '↓ Bottom'),
      (Offset(4, 4), '↘ Bottom Right'),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shadow Offset',
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: offsets.map((offsetData) {
              final isSelected = offsetData.$1 == shadowOffset;
              return InkWell(
                onTap: () {
                  setState(() => shadowOffset = offsetData.$1);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? activeColor : const Color(0xFF2A2A2A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    offsetData.$2,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.black : Colors.grey[400],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorCard(String name, Widget widget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Component with current configuration applied (responsive size)
        Flexible(
          child: FittedBox(fit: BoxFit.contain, child: _applyConfig(widget)),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _applyConfig(Widget widget) {
    // Apply configuration based on component type (alphabetically)
    if (widget is ArrowMove) {
      return ArrowMove(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Burst) {
      return Burst(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Cascade) {
      return Cascade(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Chaos) {
      return Chaos(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Checkerboard) {
      return Checkerboard(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Clockwise) {
      return Clockwise(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Converge) {
      return Converge(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Corners) {
      return Corners(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Cross) {
      return Cross(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Diamond) {
      return Diamond(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is DiagonalRace) {
      return DiagonalRace(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Flip) {
      return Flip(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is FlowDown) {
      return FlowDown(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is FlowLeft) {
      return FlowLeft(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is FlowRight) {
      return FlowRight(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is FlowUp) {
      return FlowUp(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Inward) {
      return Inward(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Pulse) {
      return Pulse(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Pulse2) {
      return Pulse2(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is PulseRing) {
      return PulseRing(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Radial) {
      return Radial(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Ripple) {
      return Ripple(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Scatter) {
      return Scatter(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is SineWave) {
      return SineWave(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Spiral) {
      return Spiral(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Spinner) {
      return Spinner(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Wave) {
      return Wave(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }
    if (widget is Zigzag) {
      return Zigzag(
        dotSize: dotSize,
        borderRadius: borderRadius,
        spacing: spacing,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        opacity: opacity,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        animationSpeed: Duration(milliseconds: animationSpeed),
        scale: scale,
        scaleAlignment: scaleAlignment,
      );
    }

    return widget;
  }

  void _showColorPicker(
    BuildContext context,
    Color currentColor,
    ValueChanged<Color> onColorChanged,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Select Color',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: _DotrixColorPicker(
            color: currentColor,
            onColorChanged: onColorChanged,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Simplified color picker (privatized naming to avoid conflicts)
class _DotrixColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const _DotrixColorPicker({required this.color, required this.onColorChanged});

  @override
  State<_DotrixColorPicker> createState() => _DotrixColorPickerState();
}

class _DotrixColorPickerState extends State<_DotrixColorPicker> {
  late Color selectedColor;

  // Preset colors
  static const presetColors = [
    Color(0xFFFFD700), // Gold
    Color(0xFFFFE57F), // Light Gold
    Color(0xFFD4AF37), // Classic Gold
    Color(0xFFC9B037), // Champagne
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Violet
    Color(0xFF10B981), // Emerald
    Color(0xFF3B82F6), // Blue
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF333333), // Dark Grey
    Color(0xFFFFFFFF), // White
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Preset color grid (use Wrap instead of GridView to avoid Viewport issues)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: presetColors.map((color) {
            final isSelected = color.toARGB32() == selectedColor.toARGB32();
            return InkWell(
              onTap: () {
                setState(() => selectedColor = color);
                widget.onColorChanged(color);
              },
              child: SizedBox(
                width: 60,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Custom color sliders
        _buildColorSlider(
          'Red',
          (selectedColor.r * 255.0).round().clamp(0, 255),
          (value) {
            setState(() {
              selectedColor = Color.fromRGBO(
                value.round().clamp(0, 255),
                (selectedColor.g * 255.0).round().clamp(0, 255),
                (selectedColor.b * 255.0).round().clamp(0, 255),
                selectedColor.a,
              );
              widget.onColorChanged(selectedColor);
            });
          },
        ),
        _buildColorSlider(
          'Green',
          (selectedColor.g * 255.0).round().clamp(0, 255),
          (value) {
            setState(() {
              selectedColor = Color.fromRGBO(
                (selectedColor.r * 255.0).round().clamp(0, 255),
                value.round().clamp(0, 255),
                (selectedColor.b * 255.0).round().clamp(0, 255),
                selectedColor.a,
              );
              widget.onColorChanged(selectedColor);
            });
          },
        ),
        _buildColorSlider(
          'Blue',
          (selectedColor.b * 255.0).round().clamp(0, 255),
          (value) {
            setState(() {
              selectedColor = Color.fromRGBO(
                (selectedColor.r * 255.0).round().clamp(0, 255),
                (selectedColor.g * 255.0).round().clamp(0, 255),
                value.round().clamp(0, 255),
                selectedColor.a,
              );
              widget.onColorChanged(selectedColor);
            });
          },
        ),
      ],
    );
  }

  Widget _buildColorSlider(
    String label,
    int value,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
          Expanded(
            child: Slider(
              value: value.toDouble(),
              min: 0,
              max: 255,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
