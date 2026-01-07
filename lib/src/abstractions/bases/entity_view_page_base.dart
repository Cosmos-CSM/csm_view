import 'package:csm_view/csm_view.dart';

/// Represents an [IEntity] based { view } page.
///
/// [TEntityTableAdapter] - Type of the inner entity table adapter.
abstract class EntityViewPageBase<TEntityTableAdapter extends IEntityTableAdapter> extends ViewPageBase implements IEntityViewPage<TEntityTableAdapter> {
  /// [EntityTable] adapter configuration.
  @override
  final TEntityTableAdapter adapter;

  /// Creates a new instance.
  const EntityViewPageBase({
    required this.adapter,
  });
}
