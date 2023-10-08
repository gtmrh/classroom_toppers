import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/sharedpref.dart';
import 'package:classroom_toppers/utils/theme.dart';
import 'package:classroom_toppers/widgets/app_logo.dart';

import '../utils/strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final String selectedOption; // Variable to hold the selected value
  // final Function(String?)
  //     onOptionChanged; // Callback function to update the selected value

  // final GlobalKey<HomeState> contentScreenKey;

  const CustomAppBar({
    // required this.selectedOption,
    // required this.onOptionChanged,
    Key? key,
    // required this.contentScreenKey,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    print("leghth>>>>${app.appController.coursesType.length}");

    return Obx(() {
      return AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          children: [
            AppLogo().appBarLogo(),
            const SizedBox(width: 8),
            Text(APP_NAME, style: AppTheme.title20),
          ],
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(8),
                  hint: Text(
                    'Batch',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: app.appController.coursesType
                      .map((e) => DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Text(
                              e.courseType.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: app.appController.cTypeId.value,
                  onChanged: (String? value) async {
                    print("object");

                    await SharedPref().setCourseType(value.toString());
                    // onOptionChanged(value);

                    // contentScreenKey.currentState!.getData();

                    app.appController.getData();
                  },
                ),
              ),
            ),
          ),

          // app.appController.coursesType.isNotEmpty
          //     ?

          const SizedBox(
            width: 5,
          )
        ],
      );
    });
  }
}
