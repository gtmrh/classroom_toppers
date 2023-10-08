// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_color.dart';

class LoginBottomSheet extends StatefulWidget {
  final String mobile;

  const LoginBottomSheet(this.mobile, {super.key});

  @override
  _LoginBottomSheetState createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  late TextEditingController _mobileNumberController;
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController(text: widget.mobile);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return view();

    // Scaffold(

    //   body: view(),
    // );
  }

  Widget view() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Row(children: [
              CloseButton(color: appColor.black),
              const Text('Login', style: TextStyle(fontSize: 24.0))
            ]),
            const SizedBox(height: 24.0),
            TextFormField(
              maxLength: 10,
              controller: _mobileNumberController,
              // initialValue: _mobileNumberController.text,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    // Handle forgot password functionality
                    Navigator.pop(context);
                    // Add your own code here
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                child: Text('Login', style: TextStyle(color: appColor.white)),
                onPressed: () {
                  if (_mobileNumberController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    // Handle login functionality
                    // Navigator.pop(context);
                    // Add your own code here
                    // app.appController.userLogin(
                    //     _mobileNumberController.text, _passwordController.text);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter mobile no. and password");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
