import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';
import 'package:lenga_edu/core/abstractions/simulation_engine.dart';

class WebSimulationEngine extends SimulationEngine {
  const WebSimulationEngine(super.sim, {super.key});

  @override
  Widget createSimulation(BuildContext context) {
    final filePath = '${sim.basePath}/${sim.entry}';

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(filePath)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
          handlerName: 'updateVariable',
          callback: (args) {
            if (args.length >= 2) {
              final id = args[0] as String;
              final value = args[1];
              context.read<SimulationController>().setVariable(id, value);
            }
          },
        );
      },
    );
  }
}
