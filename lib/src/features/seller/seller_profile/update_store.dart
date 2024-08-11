// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, avoid_print, avoid_catches_without_on_clauses
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tags/src/config/utils/validator.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/riverpod/providers/providers.dart';
import 'package:tags/src/core/widget/bottom_sheet_service.dart';
import 'package:tags/src/core/widget/image_picker_bottom_sheet.dart';
import 'package:tags/src/core/widget/picked_image_display.dart';
import 'package:tags/src/core/widget/tag_dialog.dart';
import 'package:tags/src/core/widget/tag_loader.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';
import 'package:tags/src/features/authentication/seller/widget/indicator.dart';
import 'package:tags/src/features/onboarding/widgets/app_texts.dart';

class UpdateStorePage extends StatefulHookConsumerWidget {
  const UpdateStorePage({
    super.key,
  });

  @override
  ConsumerState<UpdateStorePage> createState() => _UpdateStorePageState();
}

class _UpdateStorePageState extends ConsumerState<UpdateStorePage> {
  final businessControl = TextEditingController(
    text: HiveStorage.get(HiveKeys.companyName).toString(),
  );
  // final businessAddress = TextEditingController();
  final phoneControl = TextEditingController();
  final emailController = TextEditingController(
    text: HiveStorage.get(HiveKeys.companyEmail).toString(),
  );
  // final passwordController = TextEditingController();
  bool _isLoading = false;

  String? selectedCategory;

  final List storeCurrency = ['NGN', 'USD', 'UKR'];
  String? selectedCurrency;
  String? completePhoneNumber;

  // final List mybrandz = [
  //   "LG",
  //   "Samsung",
  //   "Tesla",
  //   "Vivo",
  //   "Sony",
  //   "Hisense",
  //   "Panasonic"
  // ];

  // String? selectedBrand;

  //country
  final List myCountry = [
    'Nigeria',
    'Ghana',
    'UK',
    'US',
  ];
  String? selectedCountry;

  //
  final List myDelivery = [
    'Free',
    'Paid'
    // "Free delivery on all orders",
    // "Free delivery above a certain amount",
    // "Fixed delivery charge for all orders",
    // "Delivery charge per kilometer",
    ,
  ];
  String? selectedDelivery;
  String? token = HiveStorage.get(HiveKeys.token);

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
    ref.read(profileProvider.notifier);
    final state = ref.watch(profileProvider);
    var images = useState(XFile(''));
    var imagesList = useState<List<XFile>>([]);
    final imagePicker = ref.read(imagePickerService);

    Future<void> updateCompany() async {
      setState(() {
        _isLoading = true;
      });
      try {
        var headers = {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        };

        var request = http.MultipartRequest(
          'PUT',
          Uri.parse('https://tags-api.onrender.com/api/company/update/'),
        );
        request.fields.addAll({
          'company_name': businessControl.text,
          'company_email': emailController.text,
          'company_phone': completePhoneNumber.toString(),
          'categories': selectedCategory.toString(),
          'company_country': selectedCountry.toString(),
          'currency': selectedCurrency.toString(),
          'delivery_plan': selectedDelivery.toString().toUpperCase(),
        });
        request.files.add(
          await http.MultipartFile.fromPath(
            'logo',
            imagesList.value[0].path,
          ),
        );
        request.files.add(
          await http.MultipartFile.fromPath('cover', imagesList.value[1].path),
        );
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          // After a successful API call
          setState(() {
            _isLoading = false;
          });

          // Show success dialog
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content:
                  const Text('Your company has been updated successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to home page
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SellerBottomNavBar(),
                    //   ),
                    // );
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          );

          //
        } else {
          setState(() {
            _isLoading = false;
          });
          print(response.reasonPhrase);
          // Navigator.pop(context);
          // Show a success message or update the UI if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response.reasonPhrase.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    }

    //
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),
      appBar: AppBar(
        title: const Text(
          'Update Store Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
            // fontSize: 22,
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
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TagColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: TagColors.white),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
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
                      title: 'Get your store set up in minutes!',
                      subz:
                          'Kindly fill in all your details to have you onboard',
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // Listing Details
                    //
                    const Text(
                      'Store Information',
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

                    TagCustomField2(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          FieldValidaor.validateEmptyfield(value!),
                      controller: businessControl,
                      title: 'Legal Business Name',
                      hintText: 'Type in your business name',
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TagCustomField(
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          FieldValidaor.validateEmptyfield(value!),
                      controller: emailController,
                      title: 'Email Address',
                      hintText: 'Type your email address',
                    ),

                    // Padding(
                    const SizedBox(
                      height: 20,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 3),
                      child: TagText(
                        text: 'Phone number',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontColor: TagColors.newText,
                      ),
                    ),

                    IntlPhoneField(
                      // key: const Key('phoneField'),
                      controller: phoneControl,
                      style: const TextStyle(
                        color: TagColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      keyboardType: TextInputType.number,
                      // validator: (value) =>
                      //     PhoneNumberValidator.validatePhoneNumber(value as String),
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: 'Enter your phone number',

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xffD0D5DD),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: TagColors.appThemeColor),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        // hintText: 'Enter your password',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: TagColors.newText,
                          fontSize: 14,
                        ),
                      ),
                      initialCountryCode: 'NG',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        completePhoneNumber = phone.completeNumber;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

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
                      decoration: InputDecoration(
                        hintText: 'Select the category of the item',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: TagColors.textGrey,
                        ),
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

                    //currency
                    const Text(
                      'Store Currency',
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
                      decoration: InputDecoration(
                        hintText: r'$ USD',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: TagColors.textGrey,
                        ),
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
                      items: storeCurrency
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
                      value: selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //delivery
                    const Text(
                      'Delivery Plan',
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
                      decoration: InputDecoration(
                        hintText: 'Select the delivery plan',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: TagColors.textGrey,
                        ),
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
                      items: myDelivery
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
                      value: selectedDelivery,
                      onChanged: (value) {
                        setState(() {
                          selectedDelivery = value;
                        });
                      },
                    ),
                    // Padding(
                    const SizedBox(
                      height: 20,
                    ),

                    //currency
                    const Text(
                      'Shop Country',
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
                      decoration: InputDecoration(
                        hintText: 'Nigeria',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: TagColors.textGrey,
                        ),
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
                      items: myCountry
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
                      value: selectedCountry,
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //
                    const Text(
                      'Upload your Company Logo',
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
                          if (images.value.path.isNotEmpty)
                            PickedImageDisplay(
                              imageList: imagesList,
                              isDark: false,
                            ),
                          if (images.value.path.isEmpty)
                            Container(
                              width: 150,
                              height: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xffFfffff),
                                border: Border.all(
                                  color: TagColors.textGrey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.galleryAdd,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    //

                    const SizedBox(
                      height: 20,
                    ),
                    //

                    const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload a cover photo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: TagColors.newText,
                            fontSize: 13,
                          ),
                        ),
                        // Container(
                        //   width: 90,
                        //   // height: 55,
                        //   padding: EdgeInsets.all(8),
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       color: Color(0xffF1F1F1),
                        //       borderRadius: BorderRadius.circular(16)),
                        //   child: Text(
                        //     "Optional",
                        //     style:TextStyle(
                        // fontFamily: 'Poppins',
                        //       fontWeight: FontWeight.w300,
                        //       color: TagColors.newText,
                        //       fontSize: 13,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
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
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: TagColors.textGrey.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.galleryAdd,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    //
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
              // Consumer(builder: (context, ref, child) {
              //   final model = ref.read(profileProvider.notifier);

              //   final state = ref.watch(profileProvider);
              //   return state.loading == Loader.loading
              //       ? const TagLoader(
              //           size: 50,
              //           color: TagColors.appThemeColor,
              //         )
              //       :
              //       // return

              // }),

              if (_isLoading)
                const TagLoader() // Customize as per your UI needs
              else
                TagButton(
                  width: MediaQuery.of(context).size.width - 70,
                  height: 55,
                  onTap: () async {
                    if (
                        // images.value.path.isNotEmpty &&
                        //   images2.value.path.isNotEmpty &&
                        businessControl.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            phoneControl.text.isNotEmpty &&
                            selectedCategory.toString().isNotEmpty &&
                            selectedDelivery.toString().isNotEmpty &&
                            selectedCurrency.toString().isNotEmpty &&
                            selectedCountry.toString().isNotEmpty) {
                      await updateCompany();
                    } else {
                      return showDialog(
                        context: context,
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
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save and Continue',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
