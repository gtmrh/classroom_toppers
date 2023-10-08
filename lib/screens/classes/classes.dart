import 'package:flutter/material.dart';
import 'package:classroom_toppers/screens/classes/free_class.dart';

import 'live_class.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: _bodyWidegt(),
          )),
    );
  }

  Widget _bodyWidegt() {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 40,
        child: TabBar(
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent),
            tabs: [
              Tab(
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Live",
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Free"),
                  ),
                ),
              ),
            ]),
      ),
      Expanded(child: TabBarView(children: [LiveClass(), FreeClass()]))
    ]);
  }
}
