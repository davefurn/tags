// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class SelectCategory extends StatefulHookConsumerWidget {
//   const SelectCategory({
//     required this.busName,
//     required this.busAddress,
//     required this.phoneNum,
//     required this.shopCountry,
//     super.key,
//   });

//   final String busName;
//   final String busAddress;
//   final String phoneNum;
//   final String shopCountry;

//   @override
//   ConsumerState<SelectCategory> createState() => _SelectCategoryState();
// }

// class _SelectCategoryState extends ConsumerState<SelectCategory> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(profileProvider.notifier).categories();
//       // ref.read(eventViewmodelProvider.notifier).eventCategory();
//     });
//     super.initState();
//   }

//   final List<ResultModel> selectedCategories = [];

//   void toggleSelection(ResultModel category) {
//     setState(() {
//       if (selectedCategories.contains(category)) {
//         selectedCategories.remove(category);
//       } else {
//         selectedCategories.add(category);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(profileProvider);
//     return RefreshIndicator.adaptive(
//       onRefresh: () async {
//         ref.read(profileProvider.notifier).categories();
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xffF8F9FF),
//         appBar: AppBar(
//           title: Text(
//             ' ',
//             style: GoogleFonts.montserrat(
//               fontWeight: FontWeight.w600,
//               color: const Color(0xff000000),
//               // fontSize: 22,
//             ),
//           ),
//           elevation: 0,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Container(
//                 height: 40,
//                 width: 40,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: AppColors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: AppColors.white)),
//                 child: const Icon(
//                   Icons.keyboard_backspace_rounded,
//                   color: Colors.black,
//                 ),
//               )),
//           backgroundColor: const Color(0xffF9F9F9),
//           shadowColor: const Color(0xffF9F9F9),
//           surfaceTintColor: const Color(0xffF9F9F9),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const TagTitleSub(
//                         title: "What do you sell?",
//                         subz:
//                             "Choose your categories to help customers find you faster.",
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),

//                       //
//                       Container(
//                         decoration: const BoxDecoration(),
//                       ),

//                       //
//                       if (state.loading != Loader.loading &&
//                           state.categories.isNotEmpty)
//                         SizedBox(
//                           height: 400,
//                           child: GridView.builder(
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 8.0,
//                               mainAxisSpacing: 8.0,
//                               childAspectRatio: 14 / 9,
//                             ),
//                             itemCount: state.categories.length,
//                             itemBuilder: (context, index) {
//                               final item = state.categories[index];
//                               final isSelected =
//                                   selectedCategories.contains(item);
//                               return GestureDetector(
//                                 onTap: () => toggleSelection(item),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Container(
//                                     // height: 50,
//                                     // width: 200,
//                                     padding: EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15.0),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 1,
//                                           blurRadius: 3,
//                                           offset: const Offset(0, 3),
//                                         ),
//                                       ],
//                                       border: Border.all(
//                                         color: isSelected
//                                             ? Colors.blue
//                                             : Colors.transparent,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           item.name.toString(),
//                                           style: TextStyle(
//                                             fontSize: 10.5,
//                                             fontWeight: FontWeight.w600,
//                                             color: isSelected
//                                                 ? Colors.blue
//                                                 : AppColors.newText,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       else if (state.loading == Loader.loading)
//                         const Center(
//                           child: SpinKitWaveSpinner(
//                             color: AppColors.appThemeColor,
//                             size: 50,
//                           ),
//                         )
//                       else
//                         const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               'No Categories available',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                         ),

//                       //
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // ElevatedButton(
//                 //   onPressed: _isLoading ? null : _loginUser,
//                 //   child: _isLoading
//                 //       ? const CircularProgressIndicator()
//                 //       : const Text('Login'),
//                 // ),
//                 const SizedBox(height: 50.0),

//                 // if (otpController.text.isNotEmpty)
//                 Consumer(builder: (context, ref, child) {
//                   final model = ref.read(registerViewmodelProvider.notifier);

//                   final state = ref.watch(registerViewmodelProvider);
//                   return state.loadStatus == Loader.loading
//                       ? const TagLoader(
//                           size: 50,
//                           color: AppColors.appThemeColor,
//                         )
//                       : TagButton(
//                           width: MediaQuery.of(context).size.width - 70,
//                           height: 55,
//                           onTap: () async {
//                             if (selectedCategories.toString().isNotEmpty) {
//                               //

//                               // String pinCode = otpController.text;
//                               final response = await model.createCompany(
//                                 formData: {
//                                   "company_name": widget.busName,
//                                   "company_phone": widget.phoneNum,
//                                   "company_country": widget.shopCountry,
//                                   "categories": selectedCategories
//                                       .map((cat) => cat.slug)
//                                       .toList(),
//                                   "company_email": widget.busAddress,

//                                   // "company_password": "tesla123",
//                                   // "categories": [
//                                   //     "automobile"
//                                   // ],
//                                 },
//                               );

//                               if (response.successMessage.isNotEmpty) {
//                                 //if successful :
//                                 //modal for success

//                                 showModalBottomSheet(
//                                   backgroundColor: Colors.white,
//                                   isDismissible: false,
//                                   context: context,
//                                   builder: (context) {
//                                     return FractionallySizedBox(
//                                       heightFactor: 0.75,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(16.0),
//                                         child: SingleChildScrollView(
//                                           child: Wrap(
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             20.0),
//                                                     child: Image.asset(
//                                                         "assets/images/success_create.png"),
//                                                   ),

//                                                   //
//                                                   const SizedBox(height: 16),
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             12),
//                                                     decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         borderRadius:
//                                                             BorderRadiusDirectional
//                                                                 .circular(15),
//                                                         border: Border.all(
//                                                           color: Colors
//                                                               .grey.shade50,
//                                                           width: 1.5,
//                                                         )),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               15.0),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           const Text(
//                                                             'Account Created Sucessfully!',
//                                                             style: TextStyle(
//                                                               fontSize: 22,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),

//                                                           const SizedBox(
//                                                               height: 8),

//                                                           const Text(
//                                                             'Setup your store and provide this details.',
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                                 fontSize: 13),
//                                                           ),

//                                                           const SizedBox(
//                                                               height: 18),

//                                                           //
//                                                           ListTile(
//                                                             contentPadding:
//                                                                 const EdgeInsets
//                                                                     .all(3),
//                                                             leading: SvgPicture
//                                                                 .asset(
//                                                                     height: 35,
//                                                                     "assets/svg/add_pro.svg"),
//                                                             title: const Text(
//                                                               'Verify your Identity',
//                                                               style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               ),
//                                                             ),
//                                                             subtitle:
//                                                                 const Text(
//                                                               'Upload a clear copy of your ID for security purposes.',
//                                                               // textAlign:
//                                                               //     TextAlign.center,
//                                                               style: TextStyle(
//                                                                   fontSize: 13),
//                                                             ),
//                                                           ),
//                                                           //

//                                                           ListTile(
//                                                             contentPadding:
//                                                                 const EdgeInsets
//                                                                     .all(3),
//                                                             leading: SvgPicture
//                                                                 .asset(
//                                                                     height: 35,
//                                                                     "assets/svg/business_details.svg"),
//                                                             title: const Text(
//                                                               'Business Details',
//                                                               style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               ),
//                                                             ),
//                                                             subtitle:
//                                                                 const Text(
//                                                               'Add your logo & cover picture on to your details.',
//                                                               // textAlign:
//                                                               //     TextAlign.center,
//                                                               style: TextStyle(
//                                                                   fontSize: 13),
//                                                             ),
//                                                           ),

//                                                           //
//                                                           ListTile(
//                                                             contentPadding:
//                                                                 const EdgeInsets
//                                                                     .all(3),
//                                                             leading: SvgPicture
//                                                                 .asset(
//                                                                     height: 35,
//                                                                     "assets/svg/add_products.svg"),
//                                                             title: const Text(
//                                                               'Add your Products',
//                                                               style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               ),
//                                                             ),
//                                                             subtitle:
//                                                                 const Text(
//                                                               'Upload clear photos with detailed descriptions.',
//                                                               // textAlign:
//                                                               //     TextAlign.center,
//                                                               style: TextStyle(
//                                                                   fontSize: 13),
//                                                             ),
//                                                           ),

//                                                           const SizedBox(
//                                                               height: 18),

//                                                           //

//                                                           TagButton(
//                                                               width: MediaQuery.of(
//                                                                           context)
//                                                                       .size
//                                                                       .width -
//                                                                   100,
//                                                               height: 55,
//                                                               onTap: () {
//                                                                 //update company
//                                                                 // Navigator.push(
//                                                                 //     context,
//                                                                 //     MaterialPageRoute(
//                                                                 //         builder:
//                                                                 //             (context) {
//                                                                 //   return const UpdateStorePage();
//                                                                 // }));
//                                                               },
//                                                               child: const Text(
//                                                                 'Update for now',
//                                                                 style: TextStyle(
//                                                                     color: AppColors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600),
//                                                               )),

//                                                           const SizedBox(
//                                                               height: 8),

//                                                           //
//                                                           GestureDetector(
//                                                             onTap: () {
//                                                               Navigator.pushReplacement(
//                                                                   context,
//                                                                   MaterialPageRoute(
//                                                                       builder:
//                                                                           (context) {
//                                                                 return const SellLoginPage();
//                                                               }));
//                                                             },
//                                                             child: Container(
//                                                               width: MediaQuery.of(
//                                                                           context)
//                                                                       .size
//                                                                       .width -
//                                                                   100,
//                                                               height: 55,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .center,
//                                                               decoration: BoxDecoration(
//                                                                   color:
//                                                                       AppColors
//                                                                           .white,
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               8)),
//                                                               child: const Text(
//                                                                 'Skip for now',
//                                                                 style: TextStyle(
//                                                                     color:
//                                                                         AppColors
//                                                                             .blue,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600),
//                                                               ),
//                                                             ),
//                                                           ),

//                                                           //
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );

//                                 //
//                               } else if (response.errorMessage.isNotEmpty) {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return TagDialog(
//                                         icon: const Icon(
//                                           Icons.error,
//                                           color: AppColors.red,
//                                           size: 50,
//                                         ),
//                                         title: 'Failed',
//                                         subtitle: response.errorMessage,
//                                         buttonColor: AppColors.red,
//                                         textColor: Colors.white,
//                                         buttonText: "Dismiss",
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                       );
//                                     });
//                               }
//                             } else {
//                               return showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return TagDialog(
//                                       icon: const Icon(
//                                         Icons.warning,
//                                         color: AppColors.red,
//                                         size: 50,
//                                       ),
//                                       title: ' ',
//                                       subtitle: "One or two must be selected",
//                                       buttonColor: AppColors.red,
//                                       textColor: Colors.white,
//                                       buttonText: "Dismiss",
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                       },
//                                     );
//                                   });
//                             }
//                           },
//                           child: Text(
//                             "Continue",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                               fontSize: 14,
//                             ),
//                           ),
//                         );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
