import 'package:flutter/material.dart';

class AppLogo {
  // const AppLogo({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Image(
  //     image: const AssetImage("assets/images/logo.png"),
  //     alignment: AlignmentDirectional.center,
  //     width: MediaQuery.of(context).size.width / 2,
  //   );
  // }

  Widget splashLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      alignment: AlignmentDirectional.center,
      width: 250,
      // colorBlendMode: ,
      // height: double.infinity/2,
    );
  }

  Widget smallLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      alignment: AlignmentDirectional.center,
      width: 150,
      // height: double.infinity/2,
    );
  }

  Widget tinyLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      alignment: AlignmentDirectional.center,
      width: 100,
      // height: double.infinity/2,
    );
  }

  Widget appBarLogo() {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      alignment: AlignmentDirectional.center,
      width: 50,
      height: 50,
      // height: double.infinity/2,
    );
  }
}
