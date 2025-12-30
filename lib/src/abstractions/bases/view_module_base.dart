import 'dart:async';
import 'dart:io';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;

part '../../widgets/_view_module_welcome.dart';
part '../../widgets/_view_module_size.dart';

/// Represents a solution { View } module.
abstract class ViewModuleBase extends StatefulWidget {
  final bool useSizingFrame;

  ///
  const ViewModuleBase({
    super.key,
    this.useSizingFrame = true,
  });

  @override
  State<ViewModuleBase> createState() => _ViewModuleBaseState();

  ///
  @protected
  Widget bootstrapBuild(BuildContext context, Widget? app) => app ?? _ViewModuleWelcome();

  @protected
  RoutingGraphBase bootstrapRouting();

  @protected
  List<IThemeData> bootstrapTheming();

  @protected
  FutureOr<void> initView() {}
}

/// State class for [ViewModuleBase].
final class _ViewModuleBaseState extends State<ViewModuleBase> {
  /// Current { View } theme data.
  late IThemeData currentTheme;

  /// Invokation object for init dependencies future resolution.
  late FutureOr<void> initDepsCall;

  /// All { View } theme datas avilable.
  late final List<IThemeData> themeDatas = widget.bootstrapTheming();

  /// { View } routing graph.
  late final RoutingGraphBase routingGraph = widget.bootstrapRouting();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    InjectorUtils.addSingleton<IRouter>(Router(routingGraph.routes));

    currentTheme = themeDatas.first;
    initDepsCall = widget.initView();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AsyncWidget<void>(
        isVoid: true,
        future: initDepsCall,
        successBuilder: (BuildContext context, void _) {
          return ThemeManager(
            themes: themeDatas,
            themeData: currentTheme,
            change: (Type newTheme) {
              setState(() {
                currentTheme = themeDatas.firstWhere(
                  (IThemeData themeData) => themeData.runtimeType == newTheme,
                );
              });
            },
            child: MaterialApp.router(
              routerConfig: routingGraph,
              restorationScopeId: 'view',
              builder: (BuildContext context, Widget? child) {
                final Widget viewBuild = DefaultTextStyle(
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  child: widget.bootstrapBuild(context, child),
                );

                if (!kDebugMode || !widget.useSizingFrame) {
                  return viewBuild;
                }

                return Stack(
                  children: <Widget>[
                    viewBuild,
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: _ViewModuleSize(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
