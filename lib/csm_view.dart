// ignore_for_file: directives_ordering

library;

// --> Package proxies
export 'package:device_info_plus/device_info_plus.dart' show AndroidDeviceInfo, IosDeviceInfo, LinuxDeviceInfo, WindowsDeviceInfo, WebBrowserInfo, BaseDeviceInfo;

//! --> Exporting modules
export 'src/widgets/widgets_module.dart';
export 'src/abstractions/abstractions_module.dart';

//! --> Exporing [src]
export 'src/abstractions/bases/view_module_base.dart';

export 'src/abstractions/bases/view_page_base.dart';
export 'src/abstractions/interfaces/iview_page.dart';

export 'src/abstractions/bases/view_layout_base.dart';
export 'src/abstractions/interfaces/iview_layout.dart';

//! --> Exporting [Routing]
export 'src/routing/router.dart';
export 'src/routing/abstractions/bases/router_base.dart';
export 'src/routing/abstractions/interfaces/irouter.dart';

export 'src/routing/routing_graph.dart';
export 'src/routing/abstractions/bases/routing_graph_base.dart';

export 'src/routing/abstractions/interfaces/irouting_grapth_leaf_data.dart';

export 'src/routing/abstractions/bases/routing_graph_data_base.dart';
export 'src/routing/abstractions/interfaces/irouting_graph_data.dart';

export 'src/routing/routing_graph_layout.dart';
export 'src/routing/abstractions/bases/routing_graph_layout_data_base.dart';
export 'src/routing/abstractions/interfaces/irouting_graph_layout_data.dart';

export 'src/routing/routing_graph_node.dart';
export 'src/routing/abstractions/bases/routing_graph_node_data_base.dart';

export 'src/routing/routing_graph_whisper.dart';
export 'src/routing/abstractions/bases/routing_graph_whisper_data_base.dart';
export 'src/routing/abstractions/interfaces/irouting_graph_whisper_data.dart';

export 'src/routing/models/route_data.dart';
export 'src/routing/models/routing_data.dart';
export 'src/routing/models/whisper_options.dart';

//! --> Exporting [Core]
export 'src/core/enums.dart';
export 'src/core/typedefs.dart';
export 'src/core/extensions.dart';

export 'src/core/mixins/console_mixin.dart';
export 'src/core/mixins/comparer_mixin.dart';
export 'src/core/mixins/platform_mixin.dart';
export 'src/core/mixins/theming_mixin.dart';
export 'src/core/mixins/themin_state_mixin.dart';

export 'src/core/utils/injector_utils.dart';
export 'src/core/utils/theming_utils.dart';
export 'src/core/utils/comparisson_utils.dart';
export 'src/core/utils/console_utils.dart';

export 'src/core/tools/widget_responsiveness/responsiveness_ratio.dart';
export 'src/core/tools/widget_responsiveness/widget_responsiveness.dart';
export 'src/core/tools/widget_responsiveness/responsiveness_breakpoint.dart';
export 'src/core/tools/widget_responsiveness/responsiveness_breakpoint_value.dart';


//! --> Exporting [Theming]
export 'src/theming/theme_manager.dart';

export 'src/theming/models/state_control_theming.dart';
export 'src/theming/models/theming_data.dart';
export 'src/theming/models/input_control_theming.dart';

export 'src/theming/abstractions/bases/theme_data_base.dart';
export 'src/theming/abstractions/interfaces/itheme_data.dart';

//! --> Exporting [Widgets]
export 'src/widgets/abstractions/bases/reactor_base.dart';
export 'src/widgets/abstractions/interfaces/ireactor.dart';

export 'src/widgets/abstractions/bases/reactive_widget_base.dart';
export 'src/widgets/abstractions/interfaces/ireactive_widget.dart';

export 'src/widgets/text_input.dart';
export 'src/widgets/button_flat.dart';
export 'src/widgets/bordered_box.dart';
export 'src/widgets/pointer_area.dart';
export 'src/widgets/theme_switcher.dart';
export 'src/widgets/reactive_widget.dart';
export 'src/widgets/loading_indicator.dart';
export 'src/widgets/responsive_widget.dart';
export 'src/widgets/async_widget/async_widget.dart';
export 'src/widgets/message_widgets/message_widget.dart';
export 'src/widgets/message_widgets/error_message_widget.dart';


//! --> Exporting [Landing]
export 'src/landing/abstractions/bases/package_landing_theme_base.dart';

export 'src/landing/abstractions/bases/package_landing_entry.dart';
export 'src/landing/abstractions/interfaces/ipackage_landing_entry.dart';

export 'src/landing/abstractions/bases/package_landing_view_base.dart';

export 'src/landing/package_landing_theme/package_landing_theme_dark.dart';
export 'src/landing/package_landing_theme/package_landing_theme_light.dart';

//! --> Exporting [Layouts]
export 'src/layouts/navigation_layout/navigation_layout.dart';
export 'src/layouts/category_layout/category_layout.dart';
