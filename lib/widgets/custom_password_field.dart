import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final BuildContext context;
  final String? errorMessage;
  final ValueChanged<String> onChanged;

  const CustomPasswordField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.context,
    required this.errorMessage,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _showError = false;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: _showError ? widget.errorMessage : null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
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
