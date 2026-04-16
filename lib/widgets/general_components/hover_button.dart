import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final String texto;
  final VoidCallback onPressed;

  /// 🎨 Colores
  final Color backgroundColor;
  final Color hoverColor;
  final Color textColor;
  final Color hoverTextColor;
  final Color borderColor;

  /// 🎯 UI
  final double borderRadius;
  final EdgeInsets padding;

  /// 🔥 opcional
  final IconData? icon;

  const HoverButton({
    super.key,
    required this.texto,
    required this.onPressed,

    /// colores base
    this.backgroundColor = Colors.transparent,
    this.hoverColor = Colors.red,
    this.textColor = Colors.red,
    this.hoverTextColor = Colors.white,
    this.borderColor = Colors.red,

    /// estilo
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

    this.icon,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHover ? widget.hoverColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: widget.borderColor),
          boxShadow: isHover
              ? [
                  BoxShadow(
                    color: widget.hoverColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onPressed,
          child: Padding(
            padding: widget.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 18,
                    color: isHover ? widget.hoverTextColor : widget.textColor,
                  ),
                  const SizedBox(width: 8),
                ],

                Text(
                  widget.texto,
                  style: TextStyle(
                    color: isHover ? widget.hoverTextColor : widget.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
