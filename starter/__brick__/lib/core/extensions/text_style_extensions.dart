import 'package:flutter/material.dart';

import 'context_extensions.dart';

/*
* Usage examples
*
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Method 1: Context extension (most common)
        Text('Welcome Back', style: context.headlineLarge),
        Text('Subtitle here', style: context.bodyMedium),
        Text('Small label', style: context.labelSmall),

        // Method 2: With modifiers
        Text('Bold Title', style: context.titleLarge?.bold),
        Text('Italic text', style: context.bodyMedium?.italic),
        Text('Custom', style: context.bodyLarge?.semiBold.size(18).colored(Colors.blue)),

        // Method 3: String extension (quick)
        'Page Title'.headlineMedium(context),
        'Description text'.bodyMedium(context, color: Colors.grey),
        'Error'.labelSmall(context, color: context.colorScheme.error),

        // Method 4: Text widget extension
        const Text('Hello').bold.centered().ellipsis(2),

        // Method 5: Chained
        Text(
          'Styled text',
          style: context.bodyLarge?.semiBold.italic.withHeight(1.5).withLetterSpacing(0.5),
        ),
      ],
    );
  }
}
* */


// Access text styles from context
extension TextStyleContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Display
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;

  // Headline
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  // Title
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;

  // Body
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;

  // Label
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
}

// Modify TextStyle easily
extension TextStyleExtensions on TextStyle {
  // Weight
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  // Style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  // Size
  TextStyle size(double size) => copyWith(fontSize: size);

  // Color
  TextStyle colored(Color color) => copyWith(color: color);

  // Height
  TextStyle withHeight(double height) => copyWith(height: height);

  // Letter spacing
  TextStyle withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
}

// Build Text widgets from String
extension TextWidgetExtensions on String {
  Text text({TextStyle? style, TextAlign? textAlign, int? maxLines, TextOverflow? overflow}) {
    return Text(
      this,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // Quick text widgets with styles (requires context)
  Widget displayLarge(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.displayLarge?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget displayMedium(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.displayMedium?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget displaySmall(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.displaySmall?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget headlineLarge(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.headlineLarge?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget headlineMedium(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.headlineMedium?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget headlineSmall(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.headlineSmall?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget titleLarge(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.titleLarge?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget titleMedium(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.titleMedium?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget titleSmall(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.titleSmall?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget bodyLarge(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.bodyLarge?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget bodyMedium(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.bodyMedium?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget bodySmall(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.bodySmall?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget labelLarge(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.labelLarge?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget labelMedium(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.labelMedium?.colored(color ?? context.colorScheme.onSurface), textAlign: align);

  Widget labelSmall(BuildContext context, {Color? color, TextAlign? align}) =>
      Text(this, style: context.labelSmall?.colored(color ?? context.colorScheme.onSurface), textAlign: align);
}

// Modify Text widget
extension TextExtensions on Text {
  Text copyWith({
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return Text(
      data ?? '',
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      softWrap: softWrap ?? this.softWrap,
    );
  }

  Text withStyle(TextStyle style) => copyWith(style: this.style?.merge(style) ?? style);
  Text withColor(Color color) => copyWith(style: (style ?? const TextStyle()).copyWith(color: color));
  Text withSize(double size) => copyWith(style: (style ?? const TextStyle()).copyWith(fontSize: size));
  Text get bold => copyWith(style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.bold));
  Text get medium => copyWith(style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.w600));
  Text get italic => copyWith(style: (style ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic));
  Text centered() => copyWith(textAlign: TextAlign.center);
  Text ellipsis([int lines = 1]) => copyWith(maxLines: lines, overflow: TextOverflow.ellipsis);
}