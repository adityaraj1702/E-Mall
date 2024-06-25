import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final BuildContext context;
  final String? errorMessage;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.context,
    required this.errorMessage,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateInput);
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _showError = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(widget.context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: _showError ? widget.errorMessage : null,
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
          onChanged: widget.onChanged,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
