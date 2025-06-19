// ignore_for_file: directives_ordering

library;

// --> Package proxies
export 'package:device_info_plus/device_info_plus.dart' show AndroidDeviceInfo, IosDeviceInfo, LinuxDeviceInfo, WindowsDeviceInfo, WebBrowserInfo, BaseDeviceInfo;

// ---> Exporting base package
export 'src/view_root.dart';

// --> Exporting [common]
export 'src/common/extensions.dart';
export 'src/common/typedefs.dart';
export 'src/common/enums.dart';

// --> Exporting [landing]
export 'src/landing/package_landing.dart';
export 'src/landing/package_landing_entry.dart';
export 'src/landing/package_landing_theme/package_landing_theme_b.dart';
export 'src/landing/package_landing_theme/package_landing_theme_dark.dart';
export 'src/landing/package_landing_theme/package_landing_theme_light.dart';

// --> Exporting [routing]
export 'src/routing/router.dart';
export 'src/routing/route.dart';
export 'src/routing/route_i.dart';
export 'src/routing/route_b.dart';
export 'src/routing/route_data.dart';
export 'src/routing/router_tree_b.dart';

// --> Exporting [routing.route_layout]
export 'src/routing/route_layout/layout_i.dart';
export 'src/routing/route_layout/layout_b.dart';
export 'src/routing/route_layout/route_layout_i.dart';
export 'src/routing/route_layout/route_layout_b.dart';
export 'src/routing/route_layout/route_layout.dart';

// --> Exporting [routing.route_node]
export 'src/routing/route_node/page_i.dart';
export 'src/routing/route_node/page_b.dart';
export 'src/routing/route_node/route_node.dart';
export 'src/routing/route_node/route_node_i.dart';
export 'src/routing/route_node/route_node_b.dart';

// --> Exporting [routing.route_whisper]
export 'src/routing/route_whisper/route_whisper_options.dart';
export 'src/routing/route_whisper/route_whisper_i.dart';
export 'src/routing/route_whisper/route_whisper_b.dart';
export 'src/routing/route_whisper/route_whisper.dart';

// ---> Exporting [theming]
export 'src/theming/theme_b.dart';
export 'src/theming/theme_i.dart';
export 'src/theming/theme_manager.dart';

// --> Exporting [theming.models]
export 'src/theming/models/simple_theming.dart';
export 'src/theming/models/complex_theming.dart';
export 'src/theming/models/state_theming.dart';

// --> Exporting [tools]
export 'src/tools/console.dart';
export 'src/tools/widget_responsiveness/widget_responsiveness.dart';
export 'src/tools/widget_responsiveness/responsiveness_ratio.dart';
export 'src/tools/widget_responsiveness/responsiveness_breakpoint.dart';
export 'src/tools/widget_responsiveness/responsiveness_breakpoint_value.dart';

// --> Exporting [utils]
export 'src/utils/domain.dart';
export 'src/utils/theming.dart';
export 'src/utils/injector.dart';
export 'src/utils/comparer.dart';
export 'src/utils/widget_focus.dart';
export 'src/utils/widget_adaption.dart';

// --> Exporting [widgets]
export 'src/widgets/colored_sized_box.dart';
export 'src/widgets/pointer_area.dart';
export 'src/widgets/responsive_widget.dart';
export 'src/widgets/data_table.dart';
export 'src/widgets/theme_switcher.dart';

// --> Exporting [widgets.adaptive_widget]
export 'src/widgets/adaptive_widget/adaptive_widget.dart';
export 'src/widgets/adaptive_widget/adaptive_widget_b.dart';

// --> Exporting [widgets.async_widget]
export 'src/widgets/async_widget/async_widget.dart';

// --> Exporting [widgets.form_widget]
export 'src/widgets/form_widget/form_widget.dart';
export 'src/widgets/form_widget/form_widget_controller.dart';

// --> Exporting [widgets.reactive_widget]
export 'src/widgets/reactive_widget/reactor_i.dart';
export 'src/widgets/reactive_widget/reactor_b.dart';
export 'src/widgets/reactive_widget/reactive_widget.dart';
export 'src/widgets/reactive_widget/reactive_widget_i.dart';
export 'src/widgets/reactive_widget/reactive_widget_b.dart';
