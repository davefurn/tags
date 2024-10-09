import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tags/src/core/constant/colors.dart';

void showSuccessBanner(BuildContext context, String successMessage) {
  if (successMessage.isNotEmpty) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        elevation: 1,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        dividerColor: Colors.transparent,
        content: Align(
          alignment: Alignment.centerRight,
          child: Container(
            alignment: Alignment.centerRight,
            height: 56,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.8,
            ),
            color: TagColors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.done,
                  color: TagColors.white,
                  size: 20.sp,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  successMessage,
                  style: TextStyle(
                    color: TagColors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: TagColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: const [
          SizedBox(),
          SizedBox(),
        ],
      ),
    );
  }
}
