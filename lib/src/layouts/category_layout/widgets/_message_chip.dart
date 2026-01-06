part of '../category_layout.dart';

/// Draws and handles an user feedback message display at the [_CategoryLayoutMessenger] stack.
final class _MessageChip extends StatefulWidget {
  /// User feedback message data.
  final UserFeedback messageData;

  /// Callback invoked when {dismiss} event is requested.
  final void Function() onDismiss;

  /// Creats a new [_MessageChip] instance.
  const _MessageChip({
    super.key,
    required this.messageData,
    required this.onDismiss,
  });

  @override
  State<_MessageChip> createState() => _MessageChipState();
}

/// Handles [State] for [_MessageChip].
final class _MessageChipState extends State<_MessageChip> {
  /// {state} current application theme data.
  late IThemeData themeData;

  /// {state} whether the current [Widget] is to be dismissed.
  bool _dismissed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    themeData = ThemingUtils.get(context);
  }

  /// {event} when the current [Widget] is to be dismissed, dismission will animate {opacity} during 500 milliseconds
  /// and after it finishes will remove the message from the stack.
  void onDismiss() {
    setState(() {
      _dismissed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserFeedback messageData = widget.messageData;

    Color accentColor = switch (messageData.severity) {
      UserFeedbackSeverities.error => themeData.controlError.accent,
      UserFeedbackSeverities.success => themeData.controlSuccess.accent,
      UserFeedbackSeverities.info => themeData.control.accent,
      UserFeedbackSeverities.warning => themeData.controlError.accent,
    };

    return AnimatedOpacity(
      duration: 500.miliseconds,
      opacity: !_dismissed ? 1 : 0,
      onEnd: widget.onDismiss,
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onClick: onDismiss,
        child: BorderedBox(
          color: accentColor,
          child: ColoredBox(
            color: accentColor.withValues(
              alpha: .8,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              child: Text(
                widget.messageData.message,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
