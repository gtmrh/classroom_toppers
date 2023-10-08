// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_color.dart';

class SignupBottomSheet extends StatefulWidget {
  final String mobile;

  const SignupBottomSheet(this.mobile, {super.key});

  @override
  _SignupBottomSheetState createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  late TextEditingController _mobileNumberController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController(text: widget.mobile);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.white,
      resizeToAvoidBottomInset: true,
      body: view(),
    );
  }

  Widget view() {
    return SingleChildScrollView(
      child: Container(
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
              const Text('Signup', style: TextStyle(fontSize: 24.0))
            ]),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(
                  Icons.person,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.mail,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              maxLength: 10,
              controller: _mobileNumberController,
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
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                child: Text('Signup', style: TextStyle(color: appColor.white)),
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _mobileNumberController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    // app.appController.userSignup(
                    //     _nameController.text,
                    //     _emailController.text,
                    //     _mobileNumberController.text,
                    //     _passwordController.text);
                  } else {
                    Fluttertoast.showToast(msg: "Fields cannot be empty");
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
