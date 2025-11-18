import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonMethods {
  static void showSimpleDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              title,
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              description,
              style: textTheme.labelMedium!.copyWith(
                color: colorScheme.onTertiaryContainer,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  Labels.close,
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  static String formatToAmPm(String utcDateString) {
    final dateTime =
        DateTime.parse(utcDateString).toLocal(); // Convert to local time
    final formatted = DateFormat('hh:mm a').format(dateTime); // e.g., 08:58 AM
    return formatted;
  }

  static String capitalizeFirstLetter(String value) {
    if (value.isEmpty) return value;

    // Replace underscores with spaces
    String formatted = value.replaceAll('_', ' ');

    // Capitalize the first letter of each word
    return formatted
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
