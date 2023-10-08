import 'package:flutter/material.dart';
import 'package:classroom_toppers/screens/pdfs/books.dart';
import 'package:classroom_toppers/screens/pdfs/study_material.dart';

class Pdfs extends StatefulWidget {
  const Pdfs({Key? key}) : super(key: key);

  @override
  State<Pdfs> createState() => _PdfsState();
}

class _PdfsState extends State<Pdfs> {
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
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Study Material"),
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
                    child: Text("Books"),
                  ),
                ),
              ),
            ]),
      ),
      const Expanded(child: TabBarView(children: [StudyMaterials(), Books()]))
    ]);
  }
}
