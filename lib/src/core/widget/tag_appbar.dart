import 'package:flutter/material.dart';

import 'package:tags/src/core/constant/colors.dart';
import 'package:tags/src/core/resources/resources.dart';

class TagBar extends StatefulWidget implements PreferredSizeWidget {
  const TagBar({
    required this.title,
    required this.isHome,
    super.key,
    // required this.onTap,
    this.myColor,
    this.actions,
  });
  final String title;
  final bool isHome;
  final Color? myColor;
  // final void Function() onTap;
  final List<Widget>? actions;

  @override
  State<TagBar> createState() => _TagBarState();

  @override
  Size get preferredSize => const Size.fromHeight(53);
}

class _TagBarState extends State<TagBar> {
  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            letterSpacing: 1,
            color: TagColors.textColor,
            // const Color(0xff344054),
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: widget.actions,
        leading: widget.isHome ==
                false // condition to allow us to resuse this TagBar in the Home Screen
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: TagColors.appThemeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: TagColors.appThemeColor),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  AssetsImages.tagLogo,
                  height: 20,
                ),
              ), // tags logo for home screen,
        // foregroundColor: Colors.white,
        backgroundColor: widget.myColor ?? Colors.white,
        shadowColor: widget.myColor ?? Colors.white,
        surfaceTintColor: widget.myColor ?? Colors.white,
      );
}
