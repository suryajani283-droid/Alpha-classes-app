import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../config.dart';

class PaymentService {
  late Razorpay _razorpay;
  void Function(String paymentId)? onSuccess;
  void Function()? onFailure;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (_) {});
  }

  void openCheckout(double amount, String courseName) {
    var options = {
      'key': AppConfig.razorpayKey,
      'amount': (amount * 100).toInt(), // in paise
      'name': AppConfig.appName,
      'description': courseName,
      'prefill': {'contact': '', 'email': ''},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      onFailure?.call();
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    onSuccess?.call(response.paymentId ?? '');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    onFailure?.call();
  }

  void dispose() {
    _razorpay.clear();
  }
}
