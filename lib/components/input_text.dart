import 'package:flutter/material.dart';

import 'custom_surfix_icon.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final String value;
  final CustomSurffixIcon suffixIcon;
  final void Function(String) validator;
  final void Function(String value) onChanged;
  final void Function(String value) onSaved;
  final bool enabled;
  final bool autofocus;
  const InputText({
    Key key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.obscureText = false,
    @optionalTypeArgs this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.minLines = 1,
    this.maxLines = 1,
    this.value,
    this.enabled = true,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      decoration: InputDecoration(
        labelText: this.label,
        hintText: this.hintText,
        suffixIcon: this.suffixIcon,
      ),
      validator: this.validator,
      onChanged: this.onChanged,
      onSaved: this.onSaved,
      minLines: this.minLines,
      maxLines: this.maxLines,
      initialValue: this.value,
      enabled: this.enabled,
      autofocus: this.autofocus,
    );
  }
}
