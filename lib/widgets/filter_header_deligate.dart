import 'package:flutter/material.dart';

class FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  FilterHeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => kToolbarHeight; // Adjust the height as needed

  @override
  double get minExtent => kToolbarHeight; // Adjust the height as needed

  @override
  bool shouldRebuild(FilterHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
