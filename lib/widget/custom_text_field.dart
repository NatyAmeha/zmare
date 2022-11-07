import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField<T> extends StatelessWidget {
  String? label;
  String? hint;
  String? value;
  Color backgroundColor;
  double fontSize;
  FontWeight fontWeight;
  TextInputType? inputType;
  TextInputAction? inputAction;
  bool autoFocus;
  IconData? prefixIcon;
  int? maxLength;
  bool showCursor;
  bool isformField;
  Widget? suffix;
  double contentPadding;
  TextEditingController? controller;
  Function(String?)? validator;
  Function(String)? onchanged;
  Function(String?)? onSaved;

  CustomTextField(
      {this.label,
      this.hint,
      this.value,
      this.backgroundColor = Colors.grey,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.maxLength,
      this.autoFocus = false,
      this.inputType,
      this.inputAction,
      this.prefixIcon,
      this.isformField = false,
      this.validator,
      this.showCursor = true,
      this.onchanged,
      this.contentPadding = 24,
      this.suffix,
      this.controller,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return !isformField
        ? TextField(
            autofocus: autoFocus,
            controller: controller,
            onChanged: (newValue) {
              onchanged?.call(newValue);
            },
            keyboardType: inputType,
            textInputAction: inputAction,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
            maxLength: maxLength,
            showCursor: showCursor,
            decoration: InputDecoration(
                suffix: suffix,
                // fillColor: backgroundColor,
                filled: true,
                label: Text(label ?? ""),
                hintText: hint ?? (label != null ? "Enter your $label" : null),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(),
                  // borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                contentPadding: EdgeInsets.all(contentPadding)),
          )
        : TextFormField(
            autofocus: autoFocus,
            controller: controller,
            validator: (v) {
              validator?.call(v);
            },
            onChanged: (newValue) {
              onchanged?.call(newValue);
            },
            onSaved: (value) {
              onSaved?.call(value);
            },
            initialValue: value,
            keyboardType: inputType,
            textInputAction: inputAction,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
            maxLength: maxLength,
            showCursor: showCursor,
            decoration: InputDecoration(
                suffix: suffix,
                // fillColor: backgroundColor,
                filled: true,
                label: Text(label ?? ""),
                hintText: label != null ? "Enter your $label" : null,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(),
                  // borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                contentPadding: EdgeInsets.all(contentPadding)),
          );
  }
}
