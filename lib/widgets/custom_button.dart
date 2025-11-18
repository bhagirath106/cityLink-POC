import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String labels;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  final bool isLessRounded;

  const CustomButton({
    super.key,
    this.isLoading = false,
    required this.labels,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    this.isLessRounded = false,
    this.textColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: widget.width ?? size.width / 1.08,
      height: widget.height ?? size.height / 17,

      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? colorScheme.onSecondaryContainer,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              size.width / 50,
            ), // button's shape
          ),
        ),
        onPressed: widget.onPressed,
        child: Ink(
          decoration: ShapeDecoration(
            color: widget.color ?? colorScheme.onSecondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width / 60),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading == true
                      ? Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(right: 25),
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                      : const SizedBox.shrink(),
                  Text(
                    widget.labels,
                    style: textTheme.bodyMedium!.copyWith(
                      color: widget.textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
