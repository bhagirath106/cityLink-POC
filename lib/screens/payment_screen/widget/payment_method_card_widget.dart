import 'package:cgc_project/util/common_method.dart';
import 'package:flutter/material.dart';

class PaymentMethodCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentMethodCardWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: size.height / 120),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 30,
            top: size.height / 55,
            bottom: size.height / 55,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: size.width / 17, color: colorScheme.surface),
                  SizedBox(width: size.width / 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CommonMethods.capitalizeFirstLetter(title),
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Radio<String>(
                value: title,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
