import 'package:flutter/material.dart';

class TagUnitChip extends StatelessWidget {
  final String tag;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;
  final VoidCallback? onLongPress;
  const TagUnitChip({
    super.key,
    required this.tag,
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.textColor = Colors.black,
    this.onTap,
    this.onTapDelete,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    const double heightOfTagUnit = 30;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.50),
          border: Border.all(
            color: borderColor.withOpacity(0.50),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(5),
        height: heightOfTagUnit,
        child: Row(
          children: [
            Expanded(
              child: Text(
                tag,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTapDelete,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                height: heightOfTagUnit,
                width: heightOfTagUnit,
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.25),
                  border: Border.all(color: Colors.red.withOpacity(0.50)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
