import 'package:flutter/material.dart';
import 'package:tags/buyer_widgets/category_widgets.dart';
import 'package:tags/widgets/colors.dart';
import '../../widgets/tag_appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isGrid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TagBar(
        isHome: false,
        title: 'Categories',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded,
                color: Color(0xff5E5E5E)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined,
                color: Color(0xff474747)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                    side: const BorderSide(color: AppColors.greyColor),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.greyColor,
                      size: 15,
                    ),
                    Text(
                      "Search for categories, product or brand",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.mic,
                      color: AppColors.greyColor,
                      size: 15,
                    ),
                    Icon(
                      Icons.image_outlined,
                      color: AppColors.greyColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "Audio & Headphones",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Color",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Conditions",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.paleBlue),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Filter ",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Image.asset(
                                "assets/images/filter_icon.png",
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 105,
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.paleBlue),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "Brands",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverGrid(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset("assets/images/Oraimo.png"),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset("assets/images/JBL.png"),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset("assets/images/Nokia.png"),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset("assets/images/Apple.png"),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset("assets/images/Sony.png"),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("assets/images/Samsung.png"),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.sizeOf(context).width / 4.25) / 6,
                    ),
                    child: Image.asset("assets/images/Tecno.png"),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width / 4.25,
                  child: Image.asset("assets/images/Xiaomi.png"),
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = false;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: isGrid == false
                          ? AppColors.paleBlue
                          : Colors.transparent,
                      child: Image.asset(
                        "assets/images/listview_icon.png",
                        height: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = true;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: isGrid == false
                          ? Colors.transparent
                          : AppColors.paleBlue,
                      child: const Icon(
                        Icons.grid_view_outlined,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
            isGrid == false
                ? SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        CategoryWidget.listCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.listCard(
                            context, "assets/images/airpods.png"),
                        CategoryWidget.listCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.listCard(
                            context, "assets/images/airpods.png"),
                        CategoryWidget.listCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.listCard(
                            context, "assets/images/airpods.png"),
                      ],
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildListDelegate(
                      [
                        CategoryWidget.gridCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.gridCard(
                            context, "assets/images/airpods.png"),
                        CategoryWidget.gridCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.gridCard(
                            context, "assets/images/airpods.png"),
                        CategoryWidget.gridCard(
                            context, "assets/images/headset.png"),
                        CategoryWidget.gridCard(
                            context, "assets/images/airpods.png"),
                      ],
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 300,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
