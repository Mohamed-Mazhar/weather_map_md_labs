import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String label;
  final TextEditingController textEditingController;
  final bool isPassword;
  final AutovalidateMode? validationMode;
  final String? Function(String? text)? validator;
  final FloatingLabelBehavior floatingLabelBehavior;

  const TextInput({
    super.key,
    required this.label,
    required this.textEditingController,
    this.validator,
    this.validationMode,
    this.isPassword = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto
  });

  @override
  State<StatefulWidget> createState() {
    return _TextInputState();
  }
}

class _TextInputState extends State<TextInput> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validator,
      autovalidateMode: widget.validationMode,
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floatingLabelBehavior,
        label: Text(widget.label),
        hintText: widget.label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
