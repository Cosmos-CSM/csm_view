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
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constrains.maxWidth,
              minHeight: constrains.maxHeight,
            ),
            child: compose(context, screenSize),
          ),
        );
      },
    );
  }
}
