import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class MySellProductPage extends StatelessWidget {
  const MySellProductPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/no_products.svg',
                height: 120,
                width: 130,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
              const TagText(
                text: 'No products yet!',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: TagColors.newGrey,
              ),
              const SizedBox(
                height: 10,
              ),
              const TagText(
                text: 'Use the "Add Product" button to add product',
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontColor: TagColors.newGrey,
              ),
            ],
          ),
        ),
      );
}
