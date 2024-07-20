import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class SuccessfulSignUp extends StatelessWidget {
  const SuccessfulSignUp({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      child: Image.asset(
                        AssetsImages.successCreate,
                      ),
                    ),

                    //
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(15),
                        border: Border.all(
                          color: Colors.grey.shade50,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Account Created Sucessfully!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            const Text(
                              'Setup your store and provide this details.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            //
                            ListTile(
                              contentPadding: const EdgeInsets.all(3),
                              leading: SvgPicture.asset(
                                height: 35,
                                Assets.addPro,
                              ),
                              title: const Text(
                                'Verify your Identity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text(
                                'Upload a clear copy of your ID for security purposes.',
                                // textAlign:
                                //     TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            //

                            ListTile(
                              contentPadding: const EdgeInsets.all(3),
                              leading: SvgPicture.asset(
                                height: 35,
                                Assets.businessDetails,
                              ),
                              title: const Text(
                                'Business Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text(
                                'Add your logo & cover picture on to your details.',
                                // textAlign:
                                //     TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            //
                            ListTile(
                              contentPadding: const EdgeInsets.all(3),
                              leading: SvgPicture.asset(
                                height: 35,
                                Assets.addProducts,
                              ),
                              title: const Text(
                                'Add your Products',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text(
                                'Upload clear photos with detailed descriptions.',
                                // textAlign:
                                //     TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            //

                            TagButton(
                              width: MediaQuery.of(
                                    context,
                                  ).size.width -
                                  100,
                              height: 55,
                              onTap: () {
                                context.pushNamed(TagRoutes.updateStore.name);
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  color: TagColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            //
                            GestureDetector(
                              onTap: () {
                                context.pushReplacementNamed(
                                  TagRoutes.sellerLogin.name,
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(
                                      context,
                                    ).size.width -
                                    100,
                                height: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: TagColors.white,
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                child: const Text(
                                  'Skip for now',
                                  style: TextStyle(
                                    color: TagColors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            //
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
