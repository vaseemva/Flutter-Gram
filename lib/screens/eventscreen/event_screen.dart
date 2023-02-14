import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/utils.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatelessWidget {
 EventScreen({Key? key}) : super(key: key);

  final razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home Screen'),
          ElevatedButton(
              onPressed: () {
                auth.signOut();
              },
              child: const Text('signout')),
          ElevatedButton(
              onPressed: () async {
                final preferences = await SharedPreferences.getInstance();
                preferences.clear();
              },
              child: const Text('clear')),
          ElevatedButton(
              onPressed: () {
                checkout();
              },
              child: const Text("Pay"))
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
    print("Payment Success${response.paymentId}");
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error${response.code.toString()}");
  }

  _handleExternalWallet() {
    print("External Wallet");
  }
}
