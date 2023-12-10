import 'package:flutter/material.dart';

class FormWidgets extends Widget {
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  static TextFormField buildFormField(
      String label,
      String hint,
      Icon icon,
      String? Function(String? value)? validator,
      void Function(String? value)? onSaved,
      bool numeric,
      {int? length}) {
    return TextFormField(
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white60),
          labelStyle: const TextStyle(color: Colors.white60),
          prefixIconColor: Colors.white24,
          prefixIcon: icon,
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
      style: const TextStyle(color: Colors.white60),
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      maxLength: numeric ? 3 : (length ?? 40),
      validator: validator,
      onSaved: (value) => onSaved!(value),
    );
  }

  static TextFormField buildFormFieldInitialValue(
      String label,
      String initialValue,
      Icon icon,
      String? Function(String? value)? validator,
      void Function(String? value)? onSaved,
      bool numeric) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white60),
          labelStyle: const TextStyle(color: Colors.white60),
          prefixIconColor: Colors.white24,
          prefixIcon: icon,
          labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      maxLength: numeric ? 3 : 40,
      validator: validator,
      onSaved: (value) => onSaved!(value),
    );
  }
}
