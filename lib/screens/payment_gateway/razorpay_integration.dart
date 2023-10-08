import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/screens/payment_gateway/api_services.dart';
import 'package:classroom_toppers/screens/payment_gateway/pay_const.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/sharedpref.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayIntegration {
  final Razorpay _razorpay = Razorpay(); //Instance of razor pay
  final razorPayKey = PayConst.RAZOR_KEY;
  final razorPaySecret = PayConst.RAZOR_SECRET;
  var itemId;

  intiateRazorPay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("success_response>>$response");

    if (response.paymentId!.isNotEmpty) {
      app.appController.assignCourse(itemId, response.paymentId.toString());
    }

    // print(response.)
    // verifySignature(
    //   signature: response.signature,
    //   paymentId: response.paymentId,
    //   orderId: response.orderId,
    // );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("response>>$response");
    // Do something when payment fails
    Get.snackbar("Fail", response.message ?? '',
        backgroundColor: Colors.white, colorText: Colors.red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("response>>$response");
    Get.snackbar("Fail", response.walletName ?? '',
        backgroundColor: Colors.white, colorText: Colors.red);
  }

  openSession(
      {required num amount,
      required String orderDesc,
      required String itemId}) async {
    var contact = await SharedPref().getUserMob();
    var email = await SharedPref().getUserEmail();
    this.itemId = itemId;

    await createOrder(amount: amount).then((orderId) {
      print("ORDER_ID>>$orderId");
      if (orderId.toString().isNotEmpty) {
        var options = {
          'key': razorPayKey, //Razor pay API Key
          'amount': amount, //in the smallest currency sub-unit.
          'name': APP_NAME,
          'order_id': orderId,
          // Generate order_id using Orders API
          'description':
              orderDesc, //Order Description to be shown in razor pay page
          // 'timeout': 60, // in seconds
          'prefill': {
            'contact': contact.toString(),
            'email': email.toString()
          } //contact number and email id of user
        };
        _razorpay.open(options);
      } else {}
    });
  }

  createOrder({
    required num amount,
  }) async {
    final myData = await ApiServices().razorPayApi(amount, "rcp_id_2");
    if (myData["status"] == "success") {
      print("payment resp>>$myData");
      return myData["body"]["id"];
    } else {
      return "";
    }
  }
}
