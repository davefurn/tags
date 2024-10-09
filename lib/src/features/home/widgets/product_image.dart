import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';

class ProductImageViewer extends StatefulWidget {
  // Default product image

  const ProductImageViewer({
    required this.images,
    required this.productImage,
    required this.ontap,
    required this.wishlist,
    super.key,
  });
  final List<String> images; // List of product images
  final String productImage;
  final VoidCallback ontap;
  final bool wishlist;

  @override
  ProductImageViewerState createState() => ProductImageViewerState();
}

class ProductImageViewerState extends State<ProductImageViewer> {
  int _currentIndex = 0; // To track the current image index

  /// Function to show the next image
  void _nextImage() {
    setState(() {
      if (_currentIndex < widget.images.length - 1) {
        _currentIndex++;
      }
    });
  }

  /// Function to show the previous image
  void _prevImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  void _shareImage() {
    Share.shareUri(
      Uri.parse(widget.images[_currentIndex]),
    ); // Share the current image URL
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // Main image container
          Container(
            height: 212.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: NetworkImage(
                  widget.images[_currentIndex], // Display the current image
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button (iPhone style)
                    GestureDetector(
                      onTap: _prevImage, // Go to the previous image
                      child: SvgPicture.asset(
                        Assets.iphoneBack,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                    // Forward button (iPhone style)
                    GestureDetector(
                      onTap: _nextImage, // Go to the next image
                      child: SvgPicture.asset(
                        Assets.iphoneForward,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Spacer
          5.verticalSpace,

          // Thumbnails and action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.images.isNotEmpty)
                // Horizontal list of product images (thumbnails)
                SizedBox(
                  height: 40.h,
                  width: 300.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex =
                              index; // Update the current image on tap
                        });
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: _currentIndex == index
                                ? Colors.blue // Highlight current image
                                : Colors.transparent,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              else
                // Display if no images are available
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'No Images available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

              // Share and Favorite buttons
              SizedBox(
                width: 50.w,
                child: Row(
                  children: [
                    // Share button
                    GestureDetector(
                      onTap: _shareImage,
                      child: Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.share,
                            color: TagColors.black,
                          ),
                        ),
                      ),
                    ),

                    // Favorite button
                    InkWell(
                      onTap: widget.ontap,
                      child: Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF6F1),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Center(
                          child: widget.wishlist == true
                              ? const Icon(
                                  Icons.favorite,
                                  color: TagColors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: TagColors.red,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
