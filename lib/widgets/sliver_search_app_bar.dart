import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_application.dart';
import '../utils/theme.dart';
import 'background_wave.dart';
import 'search_bar.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  // String id;
  // String name;

  // SliverSearchAppBar();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;

    return Stack(
      children: [
        const BackgroundWave(
          height: 220.0,
        ),
        greeting(),
        Positioned(
          top: topPadding + offset,
          left: 16,
          right: 16,
          child: const CustomSearchBar(),
        ),
        // Positioned(
        //   top: topPadding + offset + 80,
        //   left: 16,
        //   right: 16,
        //   child: Text(
        //     "What would you like to study today?",
        //     style: AppTheme.t16B,
        //   ),
        // ),
      ],
    );
  }

  Widget greeting() {
    return Obx(() {
      var name = app.appController.name;
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Hi, " + name.toString() + '\n',
                  style: AppTheme.title20,
                ),
                TextSpan(
                  text: "Welcome to MISSION",
                  style: AppTheme.t14B,
                ),
              ])),
            ],
          ),
        ),
      );
    });
  }

  @override
  double get maxExtent => 220;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
