import 'package:flutter/material.dart';

/// PassTo default and primary button
class AppPrimaryButton extends StatelessWidget {
  //region Fields
  final bool isAnimated;
  final String text;
  final GestureTapCallback onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool isEnabled;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Duration? duration;
  final Curve? curve;

  //endregion

  //region Constructors
  /// PassTo default and primary button
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.fontSize,
    this.isEnabled = true,
  })  : isAnimated = false,
        duration = null,
        curve = null;

  //endregion

  //region Constructing UI
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          if (isEnabled) onTap();
        },
        child: Opacity(
          opacity: isEnabled ? 1 : 0.7,
          child: _buildContainer(context: context, child: _buildText(context)),
        ),
      ),
    );
  }

  Widget _buildContainer({required BuildContext context, required Widget child}) {
    final btnWidth = width ?? double.infinity;
    final padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: height == null ? 12 : 0);
    const alignment = Alignment.center;
    final decoration = BoxDecoration(
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      color: Colors.lightBlue,
    );
    return isAnimated
        ? AnimatedContainer(
            duration: duration!,
            curve: curve ?? Curves.linear,
            width: btnWidth,
            padding: padding,
            alignment: alignment,
            decoration: decoration,
            child: child)
        : Container(
            width: btnWidth,
            height: height,
            padding: padding,
            alignment: alignment,
            decoration: decoration,
            child: child);
  }

  Widget _buildText(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: fontSize ?? 16,
        ));
  }
//endregion
}
