import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';

Future<void> initializeAndDisplayPaymentSheet(
  BuildContext context,
  String secret,
) async {
  try {
    // Step 1: Initialize the Payment Sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: secret, // Gotten from your payment intent
        style: ThemeMode.dark,
        merchantDisplayName: 'Ikay',
      ),
    );

    // Step 2: Display the Payment Sheet
    if (context.mounted) {
      await displayPaymentSheet(context);
    }
  } on Exception catch (e) {
    log('Error initializing payment sheet: $e');
    if (context.mounted) {
      showErrorDialog(context, 'Initialization failed. Please try again.');
    }
  }
}

// Function to display the payment sheet and handle payment completion
Future<void> displayPaymentSheet(BuildContext context) async {
  try {
    // Present the payment sheet
    await Stripe.instance.presentPaymentSheet();

    // If the payment is successful, show a success dialog
    if (context.mounted) {
      showSuccessDialog(context);
      context.canPop();
    }
  } on StripeException catch (e) {
    // If Stripe throws an exception, log it and show a failure dialog
    log('StripeException: $e');
    if (context.mounted) {
      showErrorDialog(context, 'Payment failed. Please try again.');
    }
  } on Exception catch (e) {
    // Catch any other errors and log them
    log('Payment error: $e');
    if (context.mounted) {
      showErrorDialog(
        context,
        'An unexpected error occurred. Please try again.',
      );
    }
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => TagDialog(
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 50,
      ),
      title: 'Payment Successful',
      buttonColor: TagColors.red,
      textColor: Colors.white,
      buttonText: 'Dismiss',
      onTap: () {
        Navigator.pop(context);
      },
    ),
  );
}

// Function to show an error dialog in case of failure
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => TagDialog(
      icon: const Icon(
        Icons.error,
        color: TagColors.red,
        size: 50,
      ),
      title: 'Failed',
      subtitle: message,
      buttonColor: TagColors.red,
      textColor: Colors.white,
      buttonText: 'Dismiss',
      onTap: () {
        Navigator.pop(context);
      },
    ),
  );
}
