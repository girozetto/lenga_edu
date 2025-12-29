import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lenga_edu/core/consts/directory_consts.dart';
import 'package:provider/provider.dart';
import 'package:lenga_edu/core/controllers/simulation_controller.dart';
import 'package:lenga_edu/core/abstractions/simulation_engine.dart';
import 'package:lenga_edu/core/events/simulation_event.dart';

class AssetWebSimulationEngine extends SimulationEngine {
  const AssetWebSimulationEngine(super.sim, {super.key});

  @override
  Widget createSimulation(BuildContext context) {
    return _AssetWebSimulationView(
      controller: context.read<SimulationController>(),
    );
  }
}

class _AssetWebSimulationView extends StatefulWidget {
  final SimulationController controller;

  const _AssetWebSimulationView({required this.controller});

  @override
  State<_AssetWebSimulationView> createState() =>
      _AssetWebSimulationViewState();
}

class _AssetWebSimulationViewState extends State<_AssetWebSimulationView> {
  InAppWebViewController? _webViewController;
  StreamSubscription<SimulationEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _eventSubscription = widget.controller.onEvent.listen(
      _handleSimulationEvent,
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  void _handleSimulationEvent(SimulationEvent event) {
    if (event is ParameterChangedEvent) {
      _webViewController?.evaluateJavascript(
        source:
            """
        window.dispatchEvent(new CustomEvent('lenga:parameterUpdate', {
          detail: { id: '${event.id}', value: ${jsonEncode(event.value)} }
        }));
      """,
      );
    }
  }

  String get _bridgeScript => """
    window.lenga = {
      updateVariable: function(id, value) {
        window.flutter_inappwebview.callHandler('updateVariable', id, value);
      }
    };
  """;

  @override
  Widget build(BuildContext context) {
    final sim = widget.controller.simulation;
    final assetPath = '${DirectoryConsts.simulationsDir}/${sim.entry}';

    return InAppWebView(
      initialFile: assetPath,
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      initialUserScripts: UnmodifiableListView<UserScript>([
        UserScript(
          source: _bridgeScript,
          injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
        ),
      ]),
      onWebViewCreated: (controller) {
        _webViewController = controller;

        // Inject the bridge as soon as possible
        controller.addJavaScriptHandler(
          handlerName: 'updateVariable',
          callback: (args) {
            if (args.length >= 2) {
              final id = args[0] as String;
              final value = args[1];
              widget.controller.setVariable(id, value);
            }
          },
        );
      },
      onLoadStop: (controller, url) async {
        // Bridge already injected via initialUserScripts
      },
    );
  }
}
