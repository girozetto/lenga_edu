import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lenga_edu/core/abstractions/simulation_engine.dart';

class WebSimulationEngine extends SimulationEngine {
  const WebSimulationEngine(super.sim, {super.key});

  @override
  Widget createSimulation(BuildContext context) {
    final filePath = '${sim.basePath}/${sim.entry}';

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(filePath)),
      initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
    );
  }
}
