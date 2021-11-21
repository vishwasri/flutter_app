import 'package:flutter/material.dart';
import 'package:yukon/util/colors.dart';

class MyButton extends StatelessWidget {
  final Function? onTap;
  final String label;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final bool isFull;

  const MyButton(
      {required this.onTap,
      required this.label,
      this.color = COLOR_PRIMARY,
      this.textColor = Colors.white,
      this.borderColor = COLOR_PRIMARY,
      this.isFull = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: isFull ? null : MediaQuery.of(context).size.width / 2,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
