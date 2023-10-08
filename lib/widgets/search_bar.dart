import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/model/course_model/courses_data.dart';
import 'package:classroom_toppers/utils/my_application.dart';

import '../core/repo/api_repository.dart';
import '../utils/app_color.dart';
import '../utils/strings.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        height: 60,
        child: _search());
  }

  Widget _search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          shape: BoxShape.rectangle,
          color: appColor.fill),
      child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              // keyboardType: TextInputType.,
              onSubmitted: (value) {
                // Fluttertoast.showToast(msg: "msg");
              },
              scrollPadding: const EdgeInsets.only(bottom: 40),
              style: const TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                // filled: true,
                // fillColor: Colors.white,
                // focusColor: appColor.greyDark,
                // focusedBorder: _border(appColor.greyDark),
                // border: _border(appColor.greyDark),
                // enabledBorder: _border(appColor.greyDark),

                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

                hintText: 'Search Course...',
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: appColor.black,
                  // size: 30,
                ),
              ),
              controller: _searchCtrl),
          suggestionsCallback: ApiRepo().getItemSugg,
          itemBuilder: (context, CoursesData? suggestion) {
            final service = suggestion!;

            return ListTile(
              title: Text(service.name.toString()),
            );
          },
          noItemsFoundBuilder: (context) => const SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No Course Found',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
          onSuggestionSelected: (CoursesData? suggestion) {
            final data = suggestion!;
            _searchCtrl.text = data.name.toString();
            print(data.id.toString());

            //if course assigned, send to my course details/else send to course detail to buy course
            if (app.appController.asgnIdList.contains(data.id.toString())) {
              Get.toNamed(My_Course_Details_Screen, arguments: data.id);
            } else {
              Get.toNamed(Course_Details_Screen, arguments: data.id);
            }

            //course details
          }),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: color),
      borderRadius: BorderRadius.circular(12),
      gapPadding: 2);

  Widget rotate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 10.0, height: 100.0),
        const Text(
          'Flutter',
          style: TextStyle(fontSize: 40.0),
        ),
        const SizedBox(width: 15.0, height: 100.0),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 35.0,
          ),
          child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                RotateAnimatedText('AWESOME'),
                RotateAnimatedText('Text'),
                RotateAnimatedText('Animation'),
              ]),
        ),
      ],
    );
  }
}
