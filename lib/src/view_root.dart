import 'dart:io';

import 'package:csm_view/csm_view.dart' hide ColoredSizedBox;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart' hide Theme;

part '_view_root_size.dart';
part './_view_root_welcome.dart';

/// Core class for [ViewRoot].
/// Defines a core fuctionallity class for [ViewRoot].
///
/// [TThemeB] - The abstraction base for [ThemeB] management and interface.
///
/// [ViewRoot] concept: the core of a foundation [COSMOS] project solution, it handles,
/// builds and manages everything related to the main features and tools provided by the package.
/// Replaces the usually used [MaterialApp] with a high level abtraction to generate easiest way projects implementations
/// context.
///
/// (@category Applications)
final class ViewRoot<TThemeB extends ThemeB> extends StatefulWidget {
  /// [ThemeB] base implementation to use when no theme was reached.
  final TThemeB defaultTheme;

  /// Defines all possible [TThemeB] implementations possible to the [ThemeManager].
  final List<TThemeB> themes;

  /// Entry point [Widget] usually drawn when no [Routing] configuration given.
  final Widget? home;

  /// Entry point [Widget] builded usually drawn when no [Routing] configuration given.
  final Widget Function(BuildContext context)? homeBuilder;

  /// General application builder, to wrap all the [Routing] resolutions into this build.
  ///
  /// [context] - the current render tree context.
  ///
  /// [app] - the resolved [Routing] management resolution building the current app rendering.
  final Widget Function(BuildContext context, Widget? app)? builder;

  /// A delegate for [Routing] behavior.
  final RouterDelegate<Object>? routerDelegate;

  /// Custom configuration for [Routing] behavior.
  final RouterConfig<Object>? routerConfig;

  /// Wheter the application should listen and render the current [Frame].
  final bool listenFrame;

  /// Wheter the application should use legacy debug indicator banner.
  final bool useLegacyDebugBanner;

  /// Generates a new [ViewRoot] application.
  const ViewRoot({
    super.key,
    this.homeBuilder,
    this.home,
    this.builder,
    this.routerConfig,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrame = false,
    this.useLegacyDebugBanner = false,
    required this.defaultTheme,
  }) : assert(((home != null) != (homeBuilder != null)) || (home == null && homeBuilder == null), "The home widget and builder cannot be at the same time, must be just one or no one");

  /// Generates a new [ViewRoot] application.
  ///
  /// Based on a required [Routing] configuration or delegation.
  const ViewRoot.router({
    super.key,
    this.builder,
    this.routerConfig,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrame = false,
    this.useLegacyDebugBanner = false,
    required this.defaultTheme,
  })  : assert(routerConfig != null || routerDelegate != null, "Router config or Router delegate must be defined to use a router based Cosmos App"),
        homeBuilder = null,
        home = null;

  @override
  State<ViewRoot<ThemeB>> createState() => _ViewRootState<TThemeB>();
}

/// [ViewRoot] state handler.
final class _ViewRootState<TThemeB extends ThemeB> extends State<ViewRoot<ThemeB>> {
  late Widget? byHome;

  late ThemeManager<TThemeB> themeManager;

  @override
  void didUpdateWidget(covariant ViewRoot<ThemeB> oldWidget) {
    super.didUpdateWidget(oldWidget);

    byHome = widget.home ?? widget.homeBuilder?.call(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    themeManager = ThemeManager<TThemeB>(widget.defaultTheme as TThemeB, widget.themes as List<TThemeB>);
    GetIt.I.registerSingleton<ThemeManagerI<TThemeB>>(themeManager);

    byHome = widget.home ?? widget.homeBuilder?.call(context);
    const Console('COSMOS').message('Starting engines⚙️⚙️⚙️');
  }

  @override
  Widget build(BuildContext context) {
    return (widget.routerDelegate != null || widget.routerConfig != null) ? _buildFromRouter() : _build();
  }

  Widget _build() {
    return MaterialApp(
      home: byHome,
      builder: _frameListener,
      restorationScopeId: 'scope-main',
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildFromRouter() {
    return MaterialApp.router(
      builder: _frameListener,
      routerConfig: widget.routerConfig,
      routerDelegate: widget.routerDelegate,
      restorationScopeId: 'scope-main-router',
      debugShowCheckedModeBanner: widget.useLegacyDebugBanner,
    );
  }

  Widget _frameListener(BuildContext ctx, Widget? child) {
    return ValueListenableBuilder<ThemeB>(
      valueListenable: themeManager.notifier,
      builder: (BuildContext context, _, __) {
        Widget fixedChild = child ?? const _ViewRootWelcome();
        fixedChild = widget.builder?.call(context, fixedChild) ?? fixedChild;
        fixedChild = DefaultTextStyle(
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          child: fixedChild,
        );
        if (widget.listenFrame) {
          fixedChild = Stack(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              fixedChild,
              const Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: _ViewRootSize(),
                ),
              ),
            ],
          );
        }
        return fixedChild;
      },
    );
  }
}
