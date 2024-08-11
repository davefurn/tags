import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class StoreProfile extends StatefulWidget {
  const StoreProfile({super.key});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  final TextEditingController _legalController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: TagText(
              text: 'Store Profile',
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const TagText(
                textAlign: TextAlign.start,
                text: 'Get your store set up in minutes!',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: TagColors.black,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text: 'Kindly fill in all your details to have you onboard',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text: 'Store Information',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TagCustomField(
                textCapitalization: TextCapitalization.words,
                controller: _legalController,
                title: 'Legal Business name',
                hintText: ' Type in your business name',
              ),
              const SizedBox(
                height: 5,
              ),
              TagCustomField(
                textCapitalization: TextCapitalization.words,
                controller: _legalController,
                title: 'Business Address',
                hintText: ' Type in your business address',
              ),
              const SizedBox(
                height: 5,
              ),
              TagCustomField(
                textCapitalization: TextCapitalization.none,
                controller: _legalController,
                title: 'Phone number',
                hintText: ' +123456789',
              ),
              const SizedBox(
                height: 5,
              ),
              TagCustomField(
                textCapitalization: TextCapitalization.none,
                controller: _legalController,
                title: 'Store Currency',
                hintText: r' $USD',
              ),
              const SizedBox(
                height: 5,
              ),
              TagCustomField(
                textCapitalization: TextCapitalization.none,
                controller: _legalController,
                title: 'Shop Country',
                hintText: ' United States',
              ),
              const SizedBox(
                height: 20,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text: 'Upload your company logo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,
                child: Row(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 150,
                        minWidth: 150,
                        minHeight: 120,
                      ),
                      decoration: ShapeDecoration(
                        color: TagColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: TagColors.greyColor,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(
                              height: 32,
                              fit: BoxFit.fitHeight,
                              'assets/svg/image_add.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text: 'Upload a cover photo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,
                child: Row(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                        minWidth: 2,
                        minHeight: 120,
                      ),
                      decoration: ShapeDecoration(
                        color: TagColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: TagColors.greyColor,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(
                              height: 32,
                              fit: BoxFit.fitHeight,
                              'assets/svg/image_add.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
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
                  context.pushNamed(TagRoutes.paymentsPage.name);
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

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: TagText(
              text: 'Delivery',
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
                text: 'Add your delivery options!',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: TagColors.black,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text:
                    'Select your available delivery methods for your products,',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const TagText(
                textAlign: TextAlign.start,
                text: 'What type of delivery services do you offer?',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: TagColors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: TagColors.appThemeColor,
                      size: 14,
                    ),
                  ),
                  const TagText(
                    text: 'Free delivery on all orders',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: TagColors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: TagColors.appThemeColor,
                      size: 14,
                    ),
                  ),
                  const TagText(
                    text: 'Free delivery above a certain amount',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: TagColors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: TagColors.appThemeColor,
                      size: 14,
                    ),
                  ),
                  const TagText(
                    text: 'Fixed delivery charge for all orders',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: TagColors.black,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: TagColors.appThemeColor,
                      size: 14,
                    ),
                  ),
                  const TagText(
                    text: 'Delivery charge per kilometer',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: TagColors.black,
                  ),
                ],
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
                  context.pushNamed(TagRoutes.sellerPage.name);
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

// class UploadID extends StatefulWidget {
//   const UploadID({super.key});

//   @override
//   State<UploadID> createState() => _UploadIDState();
// }

// class _UploadIDState extends State<UploadID> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: TagText(
//             text: "Upload ID",
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             fontColor: TagColors.black,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         actions: const [
//           Text(
//             "           ",
//             style: TextStyle(
//               color: Colors.transparent,
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: ListView(
//           children: [
//             const TagText(
//               textAlign: TextAlign.start,
//               text: "Choose your preferred ID",
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               fontColor: TagColors.black,
//             ),
//             const TagText(
//               textAlign: TextAlign.start,
//               text: "Kindly Upload your ID card to upload your items",
//               fontSize: 14,
//               fontWeight: FontWeight.w300,
//               fontColor: TagColors.black,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             // SvgPicture.asset("assets/svg/id_face.svg")
//             Icon(Icons.face)
//           ],
//         ),
//       ),
//     );
//   }
// }
