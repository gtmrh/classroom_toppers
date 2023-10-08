import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/theme.dart';
import 'package:classroom_toppers/utils/widget_util.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool sendingOtp = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change Password',
        style: AppTheme.t14B,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onEditingComplete: () {
                // sendOTP();
                changePassword();
              },
              controller: _emailController,
              style: AppTheme.ttlStyl14,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: 'Email Id(Registered)',
                  hintStyle: AppTheme.ttlStyl14),
            ),
            // TextField(
            //   controller: _otpController,
            //   style: AppTheme.ttlStyl14,
            //   decoration: InputDecoration(labelText: 'OTP'),
            // ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: AppTheme.ttlStyl14,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              style: AppTheme.ttlStyl14,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
          ],
        ),
      ),
      actions: [
        sendingOtp
            ? WidgetUtil.loaderSpin()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: Colors.pinkAccent,
                  minimumSize: const Size(0, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  changePassword();
                  // Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Change Password',
                  style: AppTheme.ttlWhiteStyl14,
                ),
              ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  sendOTP() async {
    if (_emailController.text.contains("@")) {
      sendingOtp = true;
      setState(() {});
      await app.appController.getOtp(_emailController.text);
      sendingOtp = false;
    } else {
      Fluttertoast.showToast(msg: "Invalid mail id");
    }
  }

  changePassword() async {
    if (_emailController.text.contains("@")) {
      if (_passwordController.text.length > 8) {
        sendingOtp = true;
        setState(() {});
        await app.appController.changePass(_emailController.text,
            _otpController.text, _passwordController.text);

        if (app.appController.changePassModel!.status == 'success') {
          sendingOtp = true;
          setState(() {});
          Get.back();
          Fluttertoast.showToast(msg: "Password Updated");
        } else {
          Fluttertoast.showToast(msg: "Something went wrong, try again later");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Password length should be minimum of 8 character");
      }
    } else {
      Fluttertoast.showToast(msg: "Enter valid email id");
    }

    // if (_emailController.text.contains("@") &&
    //     // _otpController.text.isNotEmpty &&
    //     _passwordController.text.length>8) {
    //   sendingOtp = true;
    //   setState(() {});
    //   await app.appController.changePass(
    //       _emailController.text, _otpController.text, _passwordController.text);

    //   if (app.appController.changePassModel!.status == 'success') {
    //     Get.back();
    //     Fluttertoast.showToast(msg: "Password Updated");
    //   } else {}
    // } else {
    //   Fluttertoast.showToast(msg: "Enter valid email id and password length sould be 8");
    // }
  }
}
