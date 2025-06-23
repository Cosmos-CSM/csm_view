import 'dart:io';

import 'package:csm_view/csm_view.dart' hide ColoredSizedBox;
import 'package:csm_view/src/utils/theming.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart' hide Theme, Router;

part '_view_root_size.dart';
part './_view_root_welcome.dart';

/// {widget} class.
/// 
///
/// [TBase] the abstraction base for [ThemeDataB] management and interface.
///
/// [ViewRoot] concept: the core of a foundation [COSMOS] project solution, it handles,
/// builds and manages everything related to the main features and tools provided by the package.
/// Replaces the usually used [MaterialApp] with a high level abtraction to generate easiest way projects implementations
/// context.
///
///
/// Defines a core fuctionallity class for [ViewRoot].
///
/// (@category Applications)
final class ViewRoot extends StatefulWidget {
  /// Defines application theme data usage for theme switching management.
  ///
  /// The first entry will be used as the default.
  final List<ThemeDataI> themes;

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

  /// Callback invokation when [ViewRoot] has initialized it's view, useful for dependency injection and initialization.
  final void Function()? afterViewInit;

  /// Generates a new [ViewRoot] application.
  const ViewRoot({
    super.key,
    this.homeBuilder,
    this.home,
    this.builder,
    this.routerConfig,
    this.afterViewInit,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrame = false,
    this.useLegacyDebugBanner = false,
  }) : assert(((home != null) != (homeBuilder != null)) || (home == null && homeBuilder == null), "The home widget and builder cannot be at the same time, must be just one or no one");

  /// Generates a new [ViewRoot] application.
  ///
  /// Based on a required [Routing] configuration or delegation.
  const ViewRoot.router({
    super.key,
    this.builder,
    this.routerConfig,
    this.afterViewInit,
    this.routerDelegate,
    this.themes = const <Never>[],
    this.listenFrame = false,
    this.useLegacyDebugBanner = false,
  })  : assert(routerConfig != null || routerDelegate != null, "Router config or Router delegate must be defined to use a router based Cosmos App"),
        assert(themes.length > 0, 'At least one application theme must be provided'),
        homeBuilder = null,
        home = null;

  @override
  State<ViewRoot> createState() => _ViewRootState();
}

/// [ViewRoot] state handler.
final class _ViewRootState extends State<ViewRoot> {
  /// {state} stores the current way application build {home} page.
  late Widget? home = widget.home ?? widget.homeBuilder?.call(context);

  /// {state} stores the current application [ThemeDataI].
  late ThemeDataI themeData;

  @override
  void didUpdateWidget(covariant ViewRoot oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.home != oldWidget.home || widget.homeBuilder != oldWidget.homeBuilder) {
      home = widget.home ?? widget.homeBuilder?.call(context);
    }
  }

  @override
  void initState() {
    super.initState();
    
    const Console('COSMOS').message('⚙️⚙️ Starting engines ⚙️⚙️');

    WidgetsFlutterBinding.ensureInitialized();
    Injector.addSingleton<WidgetResponsiveness>(WidgetResponsiveness.i);
    Injector.addSingleton<Router>(Router.i);

    themeData = widget.themes.first;
    widget.afterViewInit?.call();
  }

  ///
  void changeThemeData(Type themeType) {
    setState(() {
      themeData = widget.themes.firstWhere(
        (ThemeDataI element) => element.runtimeType == themeType,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.routerDelegate != null || widget.routerConfig != null) ? _buildFromRouter() : _build();
  }

  ///
  Widget _build() {
    return ThemeManager(
      themeData: themeData,
      themes: widget.themes,
      change: changeThemeData,
      child: MaterialApp(
        home: home,
        builder: _frameListener,
        restorationScopeId: 'scope-main',
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  ///
  Widget _buildFromRouter() {
    return ThemeManager(
      themeData: themeData,
      themes: widget.themes,
      change: changeThemeData,
      child: MaterialApp.router(
        builder: _frameListener,
        routerConfig: widget.routerConfig,
        routerDelegate: widget.routerDelegate,
        restorationScopeId: 'scope-main-router',
        debugShowCheckedModeBanner: widget.useLegacyDebugBanner,
      ),
    );
  }

  ///
  Widget _frameListener(BuildContext ctx, Widget? child) {
    Widget fixedChild = child ?? const _ViewRootWelcome();
    fixedChild = widget.builder?.call(ctx, fixedChild) ?? fixedChild;
    fixedChild = DefaultTextStyle(
      key: UniqueKey(),
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
  }
}
