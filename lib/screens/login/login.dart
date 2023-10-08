import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/screens/login/signup_bottomsheet.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../utils/widget_util.dart';
import 'login_bottomsheet.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  late bool _passwordVisible = false;
  bool _showLogin = true;

  bool loading = false;

  // bool loading = false;

  @override
  void initState() {
    getLocation();
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   WidgetUtil().showAlertDialog(context);
    // });
  }

  void getLocation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: view(),
    );
  }

  view() {
    return WillPopScope(
      onWillPop: () async {
        WidgetUtil().closeApp(context);
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            // alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AppLogo().splashLogo(),
                  // WidgetUtil().appLogo(),
                  // const SizedBox(height: 24.0),

                  _showLogin ? loginForm() : signupForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Column(
      children: [
        WidgetUtil.learnLottie(),
        const SizedBox(height: 8.0),
        Text(
          startTxt,
          style: AppTheme.ttlStyl,
        ),
        const SizedBox(
          height: 8,
        ),
        // mobileField(),
        // passwordField(),
        mobileNoField(),

        passwrdField(),
        Padding(
          padding: const EdgeInsets.only(top: 3, right: 30, bottom: 5),
          child: Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                WidgetUtil().showChangePasswordDialog(context);
              },
              child: Text(
                forgetPasTxt,
                style: AppTheme.ttlStyl14,
                // textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        loading ? const CircularProgressIndicator() : loginBtn(),
        const SizedBox(
          height: 50,
        ),

        InkWell(
          onTap: () {
            _showLogin = false;
            setState(() {});
          },
          child: Text(
            signupTxt,
            style: AppTheme.ttlStyl12B,
          ),
        ),
      ],
    );
  }

  Widget signupForm() {
    return Column(
      children: [
        WidgetUtil().appSmallLogo(),
        const SizedBox(height: 8.0),
        Text(
          registerTxt,
          style: AppTheme.ttlStyl,
        ),
        nameField(),
        emailField(),
        mobileNoField(),
        passwrdField(),
        loading ? const CircularProgressIndicator() : signupBtn(),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            _showLogin = true;
            setState(() {});
          },
          child: Text(
            loginTxt,
            style: AppTheme.ttlStyl12B,
          ),
        ),
      ],
    );
  }

  Widget nameField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          scrollPadding: const EdgeInsets.only(bottom: 40),
          controller: _nameCtrl,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color.fromARGB(255, 221, 232, 254),
              hintText: 'Your Name'),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget emailField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          scrollPadding: const EdgeInsets.only(bottom: 40),
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.blueAccent,
              ),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color.fromARGB(255, 221, 232, 254),
              hintText: 'Email Id'),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget mobileNoField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          maxLength: 10,
          scrollPadding: const EdgeInsets.only(bottom: 40),
          controller: _mobileCtrl,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              counterText: "",
              prefixIcon: Icon(
                Icons.phone_iphone,
                color: Colors.blueAccent,
              ),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color.fromARGB(255, 221, 232, 254),
              hintText: 'Mobile Number'),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget passwrdField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          scrollPadding: const EdgeInsets.only(bottom: 40),
          controller: _passwordCtrl,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.blueAccent,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  )),
              border: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: const TextStyle(
                  color: Colors.blueAccent, fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: const Color.fromARGB(255, 221, 232, 254),
              hintText: 'Password'),
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget loginBtn() {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.red)))),
        onPressed: () async {
          if (_mobileCtrl.text.length == 10 && _passwordCtrl.text.isNotEmpty) {
            loading = true;
            setState(() {});
            await app.appController.userLogin(
                _mobileCtrl.text.toString(), _passwordCtrl.text.toString());
            loading = false;
            setState(() {});
          } else {
            Fluttertoast.showToast(msg: "Check mobile number and password!!");
          }

          // Get.offNamed(HOME_SCREEN);
        },
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 14),
        ));
  }

  Widget signupBtn() {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.red)))),
        onPressed: () async {
          if (_nameCtrl.text.isNotEmpty) {
            if (_emailCtrl.text.isEmail) {
              if (_mobileCtrl.text.length == 10) {
                if (_passwordCtrl.text.length > 5) {
                  loading = true;
                  setState(() {});

                  await app.appController.userSignup(_nameCtrl.text,
                      _emailCtrl.text, _mobileCtrl.text, _passwordCtrl.text);

                  loading = false;
                  setState(() {});
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter minimum 6 character password");
                }
              } else {
                Fluttertoast.showToast(msg: "Please enter valid phone number");
              }
            } else {
              Fluttertoast.showToast(msg: "Please enter valid email id");
            }
          } else {
            Fluttertoast.showToast(msg: "Please enter your name");
          }
        },
        child: const Text(
          "Signup",
          style: TextStyle(fontSize: 14),
        ));
  }

  Widget termsTxt() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: RichText(
            // overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            // textDirection: TextDirection.rtl,
            softWrap: true,
            maxLines: 2,
            // textScaleFactor: 1,
            text:
                TextSpan(text: termPrefix, style: AppTheme.subTitle, children: [
              TextSpan(
                  text: "terms",
                  style: TextStyle(color: appColor.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Fluttertoast.showToast(msg: "terms");
                    }
                  // style: TextStyle()
                  ),
              const TextSpan(text: " & "),
              TextSpan(
                  text: "privacy policy",
                  style: TextStyle(color: appColor.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Fluttertoast.showToast(msg: "privacy");
                    })
            ])),
      ),
    );
  }

  void otpDialogue(bool login) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      // isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OTP Verification',
                  style: AppTheme.title20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'We have sent you the otp code on ${_mobileCtrl.text}',
                  style: AppTheme.subTitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) async {
                    setState(() {
                      loading = true;
                    });
                    if (login) {
                      // await app.appController
                      //     .loginOtpVerify(_mobileCtrl.text, pin);

                      setState(() {
                        loading = false;
                      });

                      // if (app.appController.loginOtpVrfyModel.status!.contains('success')) {

                      // }
                    } else {
                      // await app.appController
                      //     .signupOtpVerify(_mobileCtrl.text, pin);
                      // if (app.appController.otpVerifyModel.status!
                      //     .contains('success')) {
                      //   setState(() {
                      //     loading = false;
                      //   });
                      //   // Fluttertoast.showToast(msg: 'Signup with us');
                      //   signupDialogue();
                      // }
                    }
                    // }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Resend Code',
                  style: AppTheme.ulTxt,
                ),
                loading ? WidgetUtil.loaderSpin() : Container(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  registerMob() async {
    if (_mobileCtrl.text.length == 10) {
      // await app.appController.userMobReg(_mobileCtrl.text);

      // if (app.appController.signupModel.status!.contains('success')) {
      //   otpDialogue(false);
      // } else {
      //   otpDialogue(true);

      //   // loginDialogue();
      // }
    } else {
      Fluttertoast.showToast(msg: "Enter 10 digit mobile number");
    }
  }

  loginDialogue() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LoginBottomSheet(_mobileCtrl.text);
      },
    );
  }

  signupDialogue() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SignupBottomSheet(_mobileCtrl.text);
      },
    );
  }

}
