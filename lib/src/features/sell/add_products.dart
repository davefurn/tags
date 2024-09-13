// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tags/src/config/router/constants.dart';
import 'package:tags/src/config/utils/enums.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/bottom_sheet_service.dart';
import 'package:tags/src/core/widget/image_picker_bottom_sheet.dart';
import 'package:tags/src/core/widget/picked_image_display.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class AddProductPage extends StatefulHookConsumerWidget {
  const AddProductPage({
    super.key,
  });

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final productName = TextEditingController();
  final prroductDescx = TextEditingController();
  final priceContr = TextEditingController();
  final stockC = TextEditingController();
  final returnControl = TextEditingController();

  String? selectedCategory;

  final List myCondtion = [
    'New',
    'Used',
  ];
  String? selectedCondition;

  final List mybrandz = [
    'lg',
    'Samsung',
    'Apple',
    'HP',
    'Tesla',
    'Gym bags',
    'Gloves',
    'Vivo',
    'Sony',
    'Honda',
    'Panasonic',
  ];

  String? selectedBrand;

  //
  final List myColorz = ['White', 'Black', 'Orange', 'Yellow', 'Blue', 'Green'];
  String? selectedColor;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).categories();
      // ref.read(eventViewmodelProvider.notifier).eventCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    var imagesList = useState<List<XFile>>([]);
    var documents = useState<List<PlatformFile>>([]);

    final imagePicker = ref.read(imagePickerService);
    ref.read(filePickerService);
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),
      appBar: AppBar(
        title: const Text(
          'Add Items',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
            // fontSize: 22,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leadingWidth: 55.w,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => context.goNamed(TagRoutes.sell.name),
          child: Container(
            width: 28.19.w,
            height: 27.25.h,
            margin: EdgeInsets.only(
              left: 16.w,
              right: 10.w,
              top: 12.h,
              bottom: 8.h,
            ),
            decoration: BoxDecoration(
              color: TagColors.appThemeColor,
              borderRadius: BorderRadius.circular(1000.r),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: TagColors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xffF8F9FF),
        shadowColor: const Color(0xffF8F9FF),
        surfaceTintColor: const Color(0xffF8F9FF),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await ref.read(profileProvider.notifier).categories();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TagTitleSub(
                        title: 'Add your items to start selling',
                        subz: 'Put in at least one item to launch your store ',
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      const TagTitleSub(
                        title: 'Photos',
                        subz: 'Add at least two pictures of your item',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      GestureDetector(
                        onTap: () => showTagBottomSheet(
                          child: ImagePickerWidget(
                            picker: imagePicker,
                            imageList: imagesList,
                            onImageSelected: () {},
                          ),
                          context: context,
                        ),
                        child: Column(
                          children: [
                            if (imagesList.value.isNotEmpty)
                              PickedImageDisplay(
                                imageList: imagesList,
                                isDark: false,
                              ),
                            if (imagesList.value.isEmpty)
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF9F9F9),
                                  // border: Border.all(
                                  //   color: TagColors.textGrey.withOpacity(0.5),
                                  // ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/gallery-add.svg',
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // Listing Details
                      //
                      const Text(
                        'Listing Details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff303030),
                          // fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //categories
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        hint: Text(
                          'Select the category of the item',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: TagColors.textGrey,
                          ),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Theme.of(context).colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffC6C6C6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        items: state.categories
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value.slug.toString(),
                                child: Text(
                                  value.name.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff5E5E5E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      // Padding(
                      const SizedBox(
                        height: 20,
                      ),

                      //name
                      //
                      TagCustomField2(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: productName,
                        title: 'Product Name',
                        hintText: 'Type in your product name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TagCustomField2(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: prroductDescx,
                        title: 'Product Description',
                        hintText: 'Add product description',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //product codition
                      const Text(
                        'Product Condition',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        hint: Text(
                          'Select the product condition',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: TagColors.textGrey,
                          ),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Theme.of(context).colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffC6C6C6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        items: myCondtion
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff5E5E5E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedCondition,
                        onChanged: (value) {
                          setState(() {
                            selectedCondition = value;
                          });
                        },
                      ),
                      // Padding(
                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Brand',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        hint: Text(
                          'Select the brand ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: TagColors.textGrey,
                          ),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Theme.of(context).colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffC6C6C6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        items: mybrandz
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff5E5E5E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedBrand,
                        onChanged: (value) {
                          setState(() {
                            selectedBrand = value;
                          });
                        },
                      ),
                      // Padding(
                      const SizedBox(
                        height: 20,
                      ),

                      //color
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: TagColors.newText,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        hint: Text(
                          'Select the product color',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: TagColors.textGrey,
                          ),
                        ),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Theme.of(context).colorScheme.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xffC6C6C6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        items: myColorz
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff5E5E5E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedColor,
                        onChanged: (value) {
                          setState(() {
                            selectedColor = value;
                          });
                        },
                      ),
                      // Padding(
                      const SizedBox(
                        height: 20,
                      ),

                      //price
                      TagCustomField2(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: priceContr,
                        title: 'Price',
                        // prefixText: '\u20A6 ',
                        hintText: 'Type the of price your item ',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //stock
                      TagCustomField2(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: stockC,
                        title: 'Quantity in Stock',
                        hintText: 'Type in how many items  for sale ',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TagCustomField2(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        validator: (value) =>
                            FieldValidaor.validateEmptyfield(value!),
                        controller: returnControl,
                        title: 'Return Policy',
                        hintText: 'Add your product return policy',
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'Product description document',
                      //       style: TextStyle(
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w300,
                      //         color: TagColors.newText,
                      //         fontSize: 13,
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 90,
                      //       // height: 55,
                      //       padding: const EdgeInsets.all(8),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xffF1F1F1),
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //       child: const Text(
                      //         'Optional',
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           fontWeight: FontWeight.w300,
                      //           color: TagColors.newText,
                      //           fontSize: 13,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // const SizedBox(
                      //   height: 20,
                      // ),

                      // GestureDetector(
                      //   onTap: () => showTagBottomSheet(
                      //     child: DocumentPickerWidget(
                      //       picker: filePicker,
                      //       documentList: documents,
                      //       onDocumentSelected: () {},
                      //     ),
                      //     context: context,
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       if (documents.value.isNotEmpty)
                      //         PickedDocumentDisplay(
                      //           documentList: documents,
                      //           isDark: false,
                      //         ),
                      //       if (documents.value.isEmpty)
                      //         Container(
                      //           width: 130,
                      //           height: 130,
                      //           decoration: BoxDecoration(
                      //             color: const Color(0xffF9F9F9),
                      //             borderRadius: BorderRadius.circular(15),
                      //           ),
                      //           child: Center(
                      //             child: SvgPicture.asset(
                      //               'assets/svg/file-add.svg', // Update asset path as needed
                      //             ),
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),

                      // //
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: _isLoading ? null : _loginUser,
                //   child: _isLoading
                //       ? const CircularProgressIndicator()
                //       : const Text('Login'),
                // ),
                const SizedBox(height: 50),

                // if (otpController.text.isNotEmpty)
                Consumer(
                  builder: (context, ref, child) {
                    final model = ref.read(profileProvider.notifier);

                    final state = ref.watch(profileProvider);
                    return state.loading == Loader.loading
                        ? const TagLoader(
                            size: 30,
                            color: TagColors.appThemeColor,
                          )
                        : TagButton(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 55,
                            onTap: () async {
                              if (imagesList.value.isNotEmpty &&
                                  productName.text.isNotEmpty &&
                                  prroductDescx.text.isNotEmpty &&
                                  priceContr.text.isNotEmpty &&
                                  stockC.text.isNotEmpty &&
                                  returnControl.text.isNotEmpty &&
                                  // _selectedImage != null &&
                                  selectedCategory.toString().isNotEmpty &&
                                  selectedCondition.toString().isNotEmpty &&
                                  selectedBrand.toString().isNotEmpty &&
                                  selectedColor.toString().isNotEmpty) {
                                // String pinCode = otpController.text;

                                final response = await model.createItem(
                                  formData: {
                                    'name': productName.text,
                                    'description': prroductDescx.text,
                                    'price': priceContr.text,
                                    'brand':
                                        selectedBrand.toString().toLowerCase(),
                                    'quantity': stockC.text,
                                    'condition': selectedCondition.toString(),
                                    'color': selectedColor.toString(),
                                    'return_policy': returnControl.text,
                                    'category': selectedCategory.toString(),
                                  },
                                  image: XFile(imagesList.value[0].path),
                                  image2: XFile(imagesList.value[1].path),
                                );

                                if (response.successMessage.isNotEmpty) {
                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => TagDialog(
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: TagColors.appThemeColor,
                                        size: 50,
                                      ),
                                      subtitle: response.successMessage,
                                      buttonColor: TagColors.appThemeColor,
                                      textColor: Colors.white,
                                      buttonText: 'Continue',
                                      onTap: () async {
                                        // await HiveStorage.put(
                                        //     HiveKeys.token, newToken);

                                        context.pop();
                                      },
                                    ),
                                  );
                                } else if (response.errorMessage.isNotEmpty) {
                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => TagDialog(
                                      icon: const Icon(
                                        Icons.error,
                                        color: TagColors.red,
                                        size: 50,
                                      ),
                                      title: 'Failed',
                                      subtitle: response.errorMessage,
                                      buttonColor: TagColors.red,
                                      textColor: Colors.white,
                                      buttonText: 'Dismiss',
                                      onTap: () {
                                        context.pop();
                                      },
                                    ),
                                  );
                                }
                              } else {
                                return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => TagDialog(
                                    icon: const Icon(
                                      Icons.warning,
                                      color: TagColors.red,
                                      size: 50,
                                    ),
                                    title: ' ',
                                    subtitle: 'All Fields are required',
                                    buttonColor: TagColors.red,
                                    textColor: Colors.white,
                                    buttonText: 'Dismiss',
                                    onTap: () {
                                      context.pop();
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Upload',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagTitleSub extends StatelessWidget {
  const TagTitleSub({
    required this.title,
    required this.subz,
    super.key,
  });
  final String title;
  final String subz;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subz,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: Color(0xff5E5E5E),
              fontSize: 13,
            ),
          ),
        ],
      );
}

//

//
