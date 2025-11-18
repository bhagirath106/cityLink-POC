import 'package:cgc_project/screens/voucher_screen/widget/voucher_ribbon_widget.dart';
import 'package:flutter/material.dart';

class VoucherCard extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final String? description;
  final String image;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Color labelColor;
  final bool isExpired;

  const VoucherCard({
    super.key,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.image,
    this.description,
    this.actionText,
    this.onActionTap,
    this.labelColor = Colors.pink,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: isExpired ? 0.5 : 1,
      child: Container(
        height: size.height / 8.6,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Left Label
            VoucherRibbon(label: label, color: labelColor),

            // Main Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width / 30,
                  right: size.width / 30,
                  top: size.height / 90,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(image, scale: 0.9),
                              SizedBox(width: size.width / 80),
                              Text(
                                title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (actionText != null)
                          GestureDetector(
                            onTap: onActionTap,
                            child: Text(
                              actionText!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.pink,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),
                    const Divider(),

                    // Description
                    if (description != null)
                      Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
