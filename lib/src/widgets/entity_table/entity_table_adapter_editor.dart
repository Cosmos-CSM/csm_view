import 'package:csm_client_core/csm_client_core.dart';
import 'package:flutter/material.dart';

/// Represents an [EntityTable] editor mode configuration.
///
/// [TEntity] - Type of the [IEntity] the entity table is based on.
final class EntityTableAdapterEditor<TEntity extends IEntity<TEntity>> {
  /// {event} triggered when edition is being saved.
  ///
  ///
  /// [buildContext] built-in [Widget] tree reference context.
  ///
  /// [entity] updated [TEntity] instance.
  final void Function(BuildContext buildContext, TEntity entity) onUpdate;

  /// Editor form building function.
  ///
  ///
  /// [buildContext] built-in [Widget] tree reference context.
  ///
  /// [entity] entity instance being edited.
  final Widget Function(BuildContext buildContext, TEntity entity) formBuilder;

  /// Creates a new [EntityTableAdapterEditor] instance.
  const EntityTableAdapterEditor({
    required this.onUpdate,
    required this.formBuilder,
  });
}
