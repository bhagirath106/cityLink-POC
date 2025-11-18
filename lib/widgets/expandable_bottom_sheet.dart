import 'package:flutter/material.dart';

class ExpandableBottomSheet extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController scrollController)
  collapsedBuilder;

  final Widget Function(BuildContext context, ScrollController scrollController)
  expandedBuilder;
  final DraggableScrollableController controller;
  final double initialAndMinSize;
  const ExpandableBottomSheet({
    super.key,
    required this.initialAndMinSize,
    required this.controller,
    required this.collapsedBuilder,
    required this.expandedBuilder,
  });

  @override
  State<ExpandableBottomSheet> createState() => _ExpandableBottomSheetState();
}

class _ExpandableBottomSheetState extends State<ExpandableBottomSheet> {
  double _currentSize = 0.0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: widget.controller,
      initialChildSize: widget.initialAndMinSize,
      minChildSize: widget.initialAndMinSize,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              _currentSize = notification.extent;
            });
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child:
                _currentSize > 0.5
                    ? widget.expandedBuilder(context, scrollController)
                    : widget.collapsedBuilder(context, scrollController),
          ),
        );
      },
    );
  }
}
