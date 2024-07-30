import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tags/src/core/resources/resources.dart';
import 'package:tags/src/core/widget/tag_appbar.dart';
import 'package:tags/src/features/home/models/home_models.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<ProfileModel> myProfile = [
      //order
      ProfileModel(
        action: () {},
        image: Assets.location,
        title: 'Change Location',
      ),

      //id
      ProfileModel(
        action: () {},
        image: Assets.address,
        title: 'Change Address',
      ),

      //drafts
      ProfileModel(
        action: () {},
        image: Assets.password,
        title: 'Change Password',
      ),

      //wishlist
      ProfileModel(
        action: () {},
        image: Assets.language,
        title: 'App Language',
      ),

      //rate us
      ProfileModel(
        action: () {},
        image: Assets.help,
        title: 'Help & Support',
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),
      appBar: const TagBar(
        isHome: false,
        myColor: Color(0xffF8F9FF),
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),

                //

                //
                const SizedBox(
                  height: 10,
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const Divider(
                        color: Color(0xffF1F1F1),
                        thickness: 0.5,
                      ),
                      itemCount: myProfile.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          children: [
                            //
                            SvgPicture.asset(
                              myProfile[index].image,
                              // height: 30,
                            ),

                            const SizedBox(width: 20),

                            Text(
                              myProfile[index].title,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.2,
                                color: Color(0xff1B1B1B),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
