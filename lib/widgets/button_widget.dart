import 'package:flutter/material.dart';

Widget buttonWidget({
  required VoidCallback onPress,
  required String title,
  required BuildContext context,
  bool isDisabled = false,
}) {
  double wt = MediaQuery.of(context).size.width;
  return Container(
    width: wt - 50,
    height: 40,
    child: ElevatedButton(
      onPressed: isDisabled ? null : onPress,
      style: ButtonStyle(
        backgroundColor: isDisabled
            ? WidgetStateProperty.all<Color>(Colors.grey) // Disabled color
            : WidgetStateProperty.all<Color>(
                Theme.of(context).primaryColor), // Enabled color
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: isDisabled ? Colors.black.withOpacity(0.5) : Colors.white,
            ),
      ),
    ),
  );
}
