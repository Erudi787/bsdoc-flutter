import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? hoverTextStyle;
  final VoidCallback? onTap;
  final MouseCursor? cursor;
  final Widget? suffixIcon;
  final double? iconSpacing;
  final bool enableTapFeedback;
  final bool inheritParentStyle; // New parameter to inherit parent styles
  
  const HoverText({
    super.key,
    required this.text,
    this.textStyle,
    this.hoverTextStyle,
    this.onTap,
    this.cursor,
    this.suffixIcon,
    this.iconSpacing = 4.0,
    this.enableTapFeedback = true,
    this.inheritParentStyle = true, // Default to inheriting parent style
  });
  
  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;
  bool _isTapped = false;
  
  @override
  Widget build(BuildContext context) {
    // Check if we're on mobile/touch device
    bool isMobile = !kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || 
                                defaultTargetPlatform == TargetPlatform.android);
    
    // Get the inherited text style from the current context
    TextStyle inheritedStyle = widget.inheritParentStyle 
        ? DefaultTextStyle.of(context).style 
        : TextStyle();
    
    return MouseRegion(
      cursor: widget.cursor ?? (widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic),
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: widget.enableTapFeedback ? (_) => setState(() => _isTapped = true) : null,
        onTapUp: widget.enableTapFeedback ? (_) => setState(() => _isTapped = false) : null,
        onTapCancel: widget.enableTapFeedback ? () => setState(() => _isTapped = false) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: _getTextStyle(isMobile, inheritedStyle),
            ),
            if (widget.suffixIcon != null) ...[
              SizedBox(width: widget.iconSpacing),
              widget.suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
  
  TextStyle _getTextStyle(bool isMobile, TextStyle inheritedStyle) {
    // On mobile, use tap feedback instead of hover
    bool shouldShowEffect = isMobile ? _isTapped : _isHovered;
    
    // Base style: combine inherited style with custom textStyle
    TextStyle baseStyle = widget.inheritParentStyle 
        ? inheritedStyle.merge(widget.textStyle) 
        : (widget.textStyle ?? _getDefaultStyle());
    
    if (shouldShowEffect) {
      // For hover/tap effect, add underline to the base style
      return widget.hoverTextStyle ?? baseStyle.copyWith(
        decoration: TextDecoration.underline,
      );
    } else {
      return baseStyle;
    }
  }
  
  TextStyle _getDefaultStyle() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xff3366ff),
    );
  }
  
  TextStyle _getDefaultHoverStyle() {
    return _getDefaultStyle().copyWith(
      decoration: TextDecoration.underline,
    );
  }
}