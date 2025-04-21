import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;

/// Type definition for the navigation state key.
typedef NavigationState = GlobalKey<NavigatorState>;

/// Type definition for [CSMPageBase] builder method.
typedef PageBuilder = CSMPageBase Function(BuildContext ctx, RouteData routeData);

/// Type definition for [CSMLayoutBase] builder method.
typedef LayoutBuilder = LayoutB Function(BuildContext ctx, RouteData routeData, Widget page);

/// Type definition for [Router] redirection calculation.
typedef Redirection = FutureOr<Route?> Function(BuildContext ctx, RouteData routeData);

/// Type definition for [DataMap], simplifying low level data structures.
typedef DataMap = Map<String, Object?>;

/// Type definition for [DataMapEntry], simplifying low level data structures.
typedef DataMapEntry = MapEntry<String, Object?>;
