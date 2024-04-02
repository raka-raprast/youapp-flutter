import 'package:flutter/material.dart';
import 'package:youapp_flutter/utils.dart';

class GoldenShaderMask extends StatelessWidget {
  const GoldenShaderMask({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [.1, .2, .4, .5, .6, .8, 1],
        colors: [
          FabricColors.golden1,
          FabricColors.golden2,
          FabricColors.golden3,
          FabricColors.golden4,
          FabricColors.golden5,
          FabricColors.golden6,
          FabricColors.golden7,
        ],
      ).createShader(bounds),
      child: child,
    );
  }
}

class BlueishShaderMask extends StatelessWidget {
  const BlueishShaderMask({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [
          .3,
          .8,
          1,
        ],
        colors: [
          FabricColors.blueish1,
          FabricColors.blueish2,
          FabricColors.blueish3,
        ],
      ).createShader(bounds),
      child: child,
    );
  }
}
