// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tags/home_seller/sell_auth/signup/create_company/what2sell.dart';
// import 'package:tags/home_seller/sell_page/sell_page.dart';
// import 'package:tags/utils/validator.dart';
// import 'package:tags/widgets/colors.dart';

// import '../../../../providers/app_providers.dart';
// import '../../../../widgets/app_texts.dart';
// import '../../../../widgets/tag_dialog.dart';
// import '../../../sell_page/add_products.dart';

// class CreateStorePage extends StatefulHookConsumerWidget {
//   const CreateStorePage({
//     super.key,
//   });

//   @override
//   ConsumerState<CreateStorePage> createState() => _CreateStorePageState();
// }

// class _CreateStorePageState extends ConsumerState<CreateStorePage> {
//   final businessControl = TextEditingController();
//   final businessAddress = TextEditingController();
//   final phoneControl = TextEditingController();
//   // bool _isObscure = true;

//   String? completePhoneNumber;

//   // final List mybrandz = [
//   //   "LG",
//   //   "Samsung",
//   //   "Tesla",
//   //   "Vivo",
//   //   "Sony",
//   //   "Hisense",
//   //   "Panasonic"
//   // ];

//   // String? selectedBrand;

//   //country
//   final List myCountry = [
//     "Nigeria",
//     "Ghana",
//     "UK",
//     "US",
//   ];
//   String? selectedCountry;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // ref.read(profileProvider.notifier).categories();
//       // ref.read(eventViewmodelProvider.notifier).eventCategory();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final model1 = ref.read(profileProvider.notifier);
//     // final state = ref.watch(profileProvider);
//     return Scaffold(
//       backgroundColor: const Color(0xffF8F9FF),
//       appBar: AppBar(
//         title: Text(
//           ' ',
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xff000000),
//             // fontSize: 22,
//           ),
//         ),
//         elevation: 0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Container(
//               height: 40,
//               width: 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: AppColors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: AppColors.white)),
//               child: const Icon(
//                 Icons.keyboard_backspace_rounded,
//                 color: Colors.black,
//               ),
//             )),
//         backgroundColor: const Color(0xffF9F9F9),
//         shadowColor: const Color(0xffF9F9F9),
//         surfaceTintColor: const Color(0xffF9F9F9),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Create Company!",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textColor,
//                         fontSize: 22,
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 30,
//                     ),

//                     TagCustomField2(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       validator: (value) =>
//                           FieldValidaor.validateEmptyfield(value!),
//                       controller: businessControl,
//                       title: 'Business Name',
//                       hintText: 'Type in your business name',
//                     ),

//                     // Padding(
//                     const SizedBox(
//                       height: 20,
//                     ),

//                     //name
//                     //
//                     TagCustomField2(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) =>
//                           FieldValidaor.validateEmptyfield(value!),
//                       controller: businessAddress,
//                       title: 'Business Email Address',
//                       hintText: 'email address',
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),

//                     //phone
//                     // TagCustomField2(
//                     //   autovalidateMode: AutovalidateMode.onUserInteraction,
//                     //   keyboardType: TextInputType.number,
//                     //   validator: (value) =>
//                     //       FieldValidaor.validateEmptyfield(value!),
//                     //   controller: phoneControl,
//                     //   title: 'Phone Number',
//                     //   hintText: '081381113725',
//                     // ),

//                     const Padding(
//                       padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
//                       child: TagText(
//                           text: "Phone number",
//                           fontSize: 13,
//                           fontWeight: FontWeight.w300,
//                           fontColor: AppColors.newText),
//                     ),

//                     IntlPhoneField(
//                       // key: const Key('phoneField'),
//                       controller: phoneControl,
//                       style: const TextStyle(
//                           color: AppColors.textColor,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 15),
//                       keyboardType: TextInputType.number,
//                       // validator: (value) =>
//                       //     PhoneNumberValidator.validatePhoneNumber(value as String),
//                       decoration: InputDecoration(
//                         counterText: '',
//                         border: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         hintText: '8138113725',

//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 15, horizontal: 10),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(
//                                 color: Color(0xffD0D5DD), width: 1.5)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               const BorderSide(color: AppColors.appThemeColor),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         // hintText: 'Enter your password',
//                         hintStyle: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.newGrey.withOpacity(0.6),
//                             fontSize: 13),
//                       ),
//                       initialCountryCode: 'NG',
//                       onChanged: (phone) {
//                         print(phone.completeNumber);
//                         completePhoneNumber = phone.completeNumber;
//                       },
//                     ),

//                     // Padding(
//                     const SizedBox(
//                       height: 20,
//                     ),

//                     //currency
//                     Text(
//                       "Shop Country",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w300,
//                         color: AppColors.newText,
//                         fontSize: 13,
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 8,
//                     ),
//                     DropdownButtonFormField(
//                         dropdownColor: Colors.white,
//                         decoration: InputDecoration(
//                           hintText: 'Nigeria',
//                           hintStyle: const TextStyle(
//                               fontSize: 12, color: AppColors.textGrey),
//                           filled: true,
//                           fillColor: Colors.white,
//                           // Theme.of(context).colorScheme.background,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide:
//                                 const BorderSide(color: Color(0xffC6C6C6)),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(
//                                 style: BorderStyle.none, color: Colors.white),
//                           ),
//                         ),
//                         items: myCountry
//                             .map<DropdownMenuItem<String>>(
//                                 (value) => DropdownMenuItem<String>(
//                                     value: value.toString(),
//                                     child: Text(
//                                       value.toString(),
//                                       style: GoogleFonts.montserrat(
//                                           color: const Color(0xff5E5E5E),
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14),
//                                     )))
//                             .toList(),
//                         value: selectedCountry,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedCountry = value!;
//                           });
//                         }),

//                     //
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//               // ElevatedButton(
//               //   onPressed: _isLoading ? null : _loginUser,
//               //   child: _isLoading
//               //       ? const CircularProgressIndicator()
//               //       : const Text('Login'),
//               // ),
//               const SizedBox(height: 50.0),

//               // if (otpController.text.isNotEmpty)
//               Consumer(builder: (context, ref, child) {
//                 final model = ref.read(registerViewmodelProvider.notifier);

//                 final state = ref.watch(registerViewmodelProvider);
//                 // return state.loading == Loader.loading
//                 //     ? const TagLoader(
//                 //         size: 30,
//                 //         color: AppColors.appThemeColor,
//                 //       )
//                 //     :
//                 return TagButton(
//                   width: MediaQuery.of(context).size.width - 70,
//                   height: 55,
//                   onTap: () async {
//                     if (businessControl.text.isNotEmpty &&
//                         businessAddress.text.isNotEmpty &&
//                         phoneControl.text.isNotEmpty &&
//                         selectedCountry.toString().isNotEmpty) {
// //
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) {
//                         return SelectCategory(
//                           shopCountry: selectedCountry.toString(),
//                           busName: businessControl.text,
//                           busAddress: businessAddress.text,
//                           phoneNum: completePhoneNumber.toString(),
//                           // phoneControl.text,
//                         );
//                       }));
//                     } else {
//                       return showDialog(
//                           context: context,
//                           builder: (context) {
//                             return TagDialog(
//                               icon: const Icon(
//                                 Icons.warning,
//                                 color: AppColors.red,
//                                 size: 50,
//                               ),
//                               title: ' ',
//                               subtitle: "All Fields are required",
//                               buttonColor: AppColors.red,
//                               textColor: Colors.white,
//                               buttonText: "Dismiss",
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                             );
//                           });
//                     }
//                   },
//                   child: Text(
//                     "Save and Continue",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
