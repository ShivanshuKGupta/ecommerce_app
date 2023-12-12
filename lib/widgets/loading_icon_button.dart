import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class LoadingIconButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final Widget icon;
  final ButtonStyle? style;
  final bool enabled;
  final bool? loading;
  final void Function(dynamic err)? errorHandler;
  const LoadingIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.style,
    this.enabled = true,
    this.errorHandler,
    this.loading,
  });

  @override
  State<LoadingIconButton> createState() => _LoadingIconButtonState();
}

class _LoadingIconButtonState extends State<LoadingIconButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    _loading = widget.loading ?? _loading;
    return IconButton(
      style: widget.style,
      onPressed: _loading || !widget.enabled || widget.onPressed == null
          ? null
          : () async {
              setState(() {
                _loading = true;
              });
              try {
                await widget.onPressed!();
              } catch (e) {
                showMsg(context, e.toString());
                if (widget.errorHandler != null) widget.errorHandler!(e);
              }
              if (context.mounted) {
                setState(() {
                  _loading = false;
                });
              }
            },
      icon: _loading ? circularProgressIndicator() : widget.icon,
    );
  }
}