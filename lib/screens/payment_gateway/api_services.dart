import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:classroom_toppers/screens/payment_gateway/pay_const.dart';

class ApiServices {
  final razorPayKey = PayConst.RAZOR_KEY;
  final razorPaySecret = PayConst.RAZOR_SECRET;

  razorPayApi(num amount, String recieptId) async {
    var auth =
        'Basic ${base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'))}';
    var headers = {'content-type': 'application/json', 'Authorization': auth};
    var request =
        http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    request.body = json.encode({
      "amount": amount * 100, // Amount in smallest unit like in paise for INR
      "currency": "INR", //Currency
      "receipt": recieptId //Reciept Id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("payment statuscode>>${response.statusCode}");
    if (response.statusCode == 200) {
      return {
        "status": "success",
        "body": jsonDecode(await response.stream.bytesToString())
      };
    } else {
      Fluttertoast.showToast(msg: response.reasonPhrase.toString());
      return {"status": "fail", "message": (response.reasonPhrase)};
    }
  }
}
