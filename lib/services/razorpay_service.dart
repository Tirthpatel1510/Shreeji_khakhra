import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  final void Function(PaymentSuccessResponse response)? onSuccess;
  final void Function(PaymentFailureResponse response)? onError;
  final void Function(ExternalWalletResponse response)? onExternalWallet;
  final String apiKey;

  RazorpayService({
    this.onSuccess,
    this.onError,
    this.onExternalWallet,
    this.apiKey = 'rzp_test_RujWd5ljoSbqR7',
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleWallet);
  }

  void openCheckout(int amount, {String? upiId}) {
    if (kIsWeb) {
      debugPrint('Razorpay is not supported on Web.');
      throw FlutterError('Razorpay is supported only on Android/iOS');
    }

    final prefillData = {
      'contact': '9999999999',
      'email': 'demo@gmail.com',
    };

    // Add UPI ID if provided
    if (upiId != null && upiId.isNotEmpty) {
      prefillData['vpa'] = upiId;
    }

    final options = {
      'key': apiKey,
      'amount': amount * 100,
      'name': 'Shreeji Khakhra',
      'description': 'Order Payment',
      'prefill': prefillData,
      // Show all payment methods including UPI
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Failed to open Razorpay checkout: $e');
      onError?.call(PaymentFailureResponse(-1, e.toString(), {}));
    }
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: ${response.paymentId}');
    onSuccess?.call(response);
  }

  void _handleError(PaymentFailureResponse response) {
    debugPrint('Payment Failed: ${response.message}');
    onError?.call(response);
  }

  void _handleWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    onExternalWallet?.call(response);
  }

  void dispose() {
    _razorpay.clear();
  }
}
