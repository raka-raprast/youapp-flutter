import 'package:flutter/material.dart';
import 'package:youapp_flutter/utils.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, this.body, this.appBar, this.resizeToAvoidBottomInset = false});
  final Widget? body;
  final AppBar? appBar;
  final bool resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 2,
          colors: [FabricColors.background1, FabricColors.background2, FabricColors.background3],
          stops: [0.1, 0.6, 1],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
      ),
    );
  }
}
