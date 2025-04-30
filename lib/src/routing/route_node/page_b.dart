import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

/// Base for [CSMPage].
///
/// Defines base hebavior for [CSMPage] implementation.
///
/// [CSMPage] concept: is a complex UI that designs a full user display page, wrapping content and displaying custom designs.
abstract class PageB extends StatelessWidget implements PageI {
  const PageB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {

        constrains = constrains.copyWith(
          minWidth: 500,
          minHeight: 500,
        );
        final BoxConstraints normalizedConstriants = constrains.normalize();
        Size pageSize = normalizedConstriants.biggest;

        final ScrollController hScroll = ScrollController();
        final ScrollController vScroll = ScrollController();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: hScroll,
          child: SingleChildScrollView(
            controller: vScroll,
            child: ConstrainedBox(
              constraints: normalizedConstriants,
              child: compose(
                context,
                screenSize,
                pageSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
