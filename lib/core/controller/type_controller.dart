import 'package:get/get.dart';

class DropdownOptionsController extends GetxController {
  // var dropdownOptions = <CourseTypeData>[].obs;

  // void fetchOptionsFromApi() async {
  //   // Make the API call here to fetch the options, and update the dropdownOptions list
  //   // For demonstration purposes, I'm adding some dummy options.
  //   // dropdownOptions.value = [
  //   //   DropdownOption(value: 'option1', label: 'Option 1'),
  //   //   DropdownOption(value: 'option2', label: 'Option 2'),
  //   //   DropdownOption(value: 'option3', label: 'Option 3'),
  //   // ];

  //   await app.appController.getCourseType();
  //   dropdownOptions = app.appController.coursesType.obs;
  // }

  var selectedOption = '1'.obs;

  void updateSelectedOption(String newValue) {
    selectedOption.value = newValue;
  }
}
