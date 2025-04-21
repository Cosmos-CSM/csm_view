// ignore_for_file: directives_ordering

library;

// --> Package proxies
export 'package:device_info_plus/device_info_plus.dart' show AndroidDeviceInfo, IosDeviceInfo, LinuxDeviceInfo, WindowsDeviceInfo, WebBrowserInfo, BaseDeviceInfo;
export 'package:get_it/get_it.dart' show GetIt;

// ---> Exporting base package
export 'src/view_root.dart';

// --> Exporting [common]
export 'src/common/extensions.dart';
export 'src/common/typedefs.dart';
export 'src/common/enums.dart';

// --> Exporting [landing]
export 'src/landing/package_landing.dart';
export 'src/landing/package_landing_entry.dart';

// --> Exporting [routing]
export 'src/routing/router.dart';
export 'src/routing/route.dart';
export 'src/routing/route_i.dart';
export 'src/routing/route_b.dart';
export 'src/routing/route_data.dart';

// --> Exporting [routing.route_layout]
export 'src/routing/route_layout/layout_i.dart';
export 'src/routing/route_layout/layout_b.dart';

// --> Exporting [routing.route_node]
export 'src/routing/route_node/page_i.dart';
export 'src/routing/route_node/page_b.dart';
export 'src/routing/route_node/route_node_i.dart';
export 'src/routing/route_node/route_node_b.dart';

// ---> Exporting [theming]
export 'src/theming/theme_b.dart';
export 'src/theming/theme_i.dart';
export 'src/theming/theming_manager.dart';

// --> Exporting [theming.models]
export 'src/theming/models/button_theming.dart';
export 'src/theming/models/csm_color_theme_options.dart';
export 'src/theming/models/csm_generic_theme_options.dart';
export 'src/theming/models/csm_state_theme_options.dart';

// --> Exporting [tools]
export 'src/tools/console.dart';
export 'src/tools/widget_responsiveness/widget_responsiveness.dart';
export 'src/tools/widget_responsiveness/responsiveness_ratio.dart';
export 'src/tools/widget_responsiveness/responsiveness_breakpoint.dart';
export 'src/tools/widget_responsiveness/responsiveness_breakpoint_value.dart';

// --> Exporting [utils]
export 'src/utils/domain.dart';
export 'src/utils/comparer.dart';
export 'src/utils/widget_adaption.dart';
export 'src/utils/widget_focus.dart';

// --> Exporting [widgets]
export 'src/widgets/async_widget/async_widget.dart';
export 'src/widgets/adaptive_widget_b.dart';
export 'src/widgets/adaptive_widget.dart';
