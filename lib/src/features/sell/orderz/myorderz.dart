import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';

class OrderzPage extends StatelessWidget {
  const OrderzPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: TagColors.appThemeColor),
                      color: const Color(0xffF8FFF8),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Orders',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: TagColors.newText,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '100',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: TagColors.newText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xff3088EF)),
                      color: const Color(0xffF7F9FF),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivered',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: TagColors.newText,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '200',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: TagColors.newText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFFA07F),
                      ),
                      color: const Color(0xffFFF6F1),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: TagColors.newText,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: TagColors.newText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFFF500),
                      ),
                      color: const Color(0xffFEFEF4),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipped',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: TagColors.newText,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '70',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: TagColors.newText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // const TagText(
              //   text: "No products yet!",
              //   fontSize: 14,
              //   fontWeight: FontWeight.w500,
              //   fontColor: TagColors.newGrey,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const TagText(
              //   text: "Use the \"Add Product\" button to add product",
              //   fontSize: 12,
              //   fontWeight: FontWeight.w300,
              //   fontColor: TagColors.newGrey,
              // )
            ],
          ),
        ),
      );
}
