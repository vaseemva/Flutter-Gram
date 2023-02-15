import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentBox extends StatelessWidget {
  PaymentBox({Key? key}) : super(key: key);

  final razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screensize.height * 0.45,
            width: screensize.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    premiumTagLine,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                kHeight10,
                const ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.verified,
                    color: Colors.blue,
                  ),
                  title: Text("Get a verified badge"),
                ),
                const ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.event,
                    color: Colors.blue,
                  ),
                  title: Text("Access to Events"),
                ),
                const ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.school,
                    color: Colors.blue,
                  ),
                  title: Text("Access to Courses"),
                ),
                Text(premiumTagLine2),
                kHeight10,
                SizedBox(
                  height: screensize.height * 0.05,
                  width: screensize.width * 0.55,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        checkout();
                      },
                      child: const Text(
                        "Buy Premium",
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  checkout() {
    var options = {
      'key': 'rzp_test_TaeDIIRagFSrWt',
      'amount': 100,
      'name': 'Flutter Gram',
      'description': 'Premium Subscription',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirestoreMethods().premiumUser(currentUserUid!);
  }

  _handlePaymentError(PaymentFailureResponse response, BuildContext context) {
    showSnackBar("Payment Failed", context);
  }

  _handleExternalWallet() {
    print("External Wallet");
  }
}
