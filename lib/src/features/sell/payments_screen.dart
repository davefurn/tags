import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';
import 'package:tags/src/features/sell/store_profile.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _bankNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: TagText(
            text: 'Payments',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: TagColors.black,
            textAlign: TextAlign.center,
          ),
        ),
        actions: const [
          Text(
            '           ',
            style: TextStyle(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView(
          children: [
            const TagText(
              textAlign: TextAlign.start,
              text: 'Complete your profile for faster payouts',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontColor: TagColors.black,
            ),
            const TagText(
              textAlign: TextAlign.start,
              text:
                  'Our payment information is handled securely on our platform.',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontColor: TagColors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            const TagText(
              textAlign: TextAlign.start,
              text: 'Account details',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontColor: TagColors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            TagCustomField(
              textCapitalization: TextCapitalization.none,
              controller: _bankNameController,
              title: 'Bank',
              hintText: ' Type in your bank name',
            ),
            const SizedBox(
              height: 10,
            ),
            TagCustomField(
              textCapitalization: TextCapitalization.none,
              controller: _bankNameController,
              title: 'Account Name',
              hintText: ' Type in your account name',
            ),
            const SizedBox(
              height: 10,
            ),
            TagCustomField(
              textCapitalization: TextCapitalization.none,
              controller: _bankNameController,
              title: 'Account Number',
              hintText: ' Type in your account number',
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  TagColors.appThemeColor,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    MediaQuery.sizeOf(context).width,
                    50,
                  ),
                ),
              ),
              onPressed: () {
                context.pushNamed(TagRoutes.deliveryPage.name);
              },
              child: const TagText(
                text: 'Save & Continue',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontColor: TagColors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
