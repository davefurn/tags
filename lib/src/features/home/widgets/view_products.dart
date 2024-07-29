import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productBrand,
    required this.slug,
    super.key,
  });

  final String productImage;
  final String productTitle;
  final String productPrice;
  final String productBrand;
  final String slug;

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          title: const Text(
            'Product Details',
            style: TextStyle(
              fontFamily: 'montserrat',
              // fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TagColors.appThemeColor,
                shape: BoxShape.circle,
                border: Border.all(color: TagColors.appThemeColor),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              icon: Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: TagColors.white),
                ),
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                Center(
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 100,
                    child: Image.network(
                      widget.productImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //

                const SizedBox(
                  height: 10,
                ),
                TagText2(
                  text: widget.productTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: TagColors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                TagText(
                  text: widget.productPrice,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontColor: TagColors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                TagText(
                  text: 'Brand : ${widget.slug}',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontColor: TagColors.black,
                ),

                const SizedBox(
                  height: 50,
                ),

                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(color: TagColors.textGrey),
                // ),
              ],
            ),
          ),
        ),
      );
}
