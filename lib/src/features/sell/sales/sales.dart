import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';



class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

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
                    border: Border.all(color: TagColors.textGrey),
                    color: TagColors.white,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: r'$ 100',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff303030),
                              ),
                            ),
                            TextSpan(
                              text: '/months',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff303030),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
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
                    border: Border.all(color: TagColors.textGrey),
                    color: TagColors.white,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Orders',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '500',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff303030),
                              ),
                            ),
                            TextSpan(
                              text: '/units',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff303030),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
