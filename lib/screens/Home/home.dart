import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_fade/image_fade.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/screens/BottomSheetFilter/all-filter.dart';
import 'package:project_decision/screens/Home/filter-bar.dart';
import 'package:project_decision/screens/Home/food-item.dart';
import 'package:project_decision/screens/Home/home-controller.dart';
import 'package:project_decision/widget-size.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EDF3),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return SafeArea(
              bottom: false,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    controller: controller.scrollController,
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 70),
                    child: Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/add-food");
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffFD7C4F),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                          const Gap(20),
                          WidgetSizeOffset(
                            globalKey: controller.globalKeyTextField,
                            onChange: (size, offset) {
                              controller.textFieldOriginPoint.value =
                                  offset.dy +
                                      controller.scrollController.offset;
                            },
                            child: Container(height: 45),
                          ),
                          const Gap(20),
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/banner2.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const Gap(20),
                          GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            // childAspectRatio: ,
                            mainAxisSpacing: 5,
                            children: [
                              ...controller.categoriesData.mapIndexed((i, e) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      '/category',
                                      arguments: e,
                                    );
                                  },
                                  child: LayoutBuilder(builder: (context, ctr) {
                                    return Container(
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: ctr.maxWidth * 0.7,
                                            height: ctr.maxWidth * 0.7,
                                            // decoration: BoxDecoration(
                                            //   shape: BoxShape.circle,
                                            //   color: Colors.grey[200],
                                            // ),
                                            child: e['imageFile'] != null
                                                ? Image(
                                                    image: FileImage(
                                                        e['imageFile']),
                                                    fit: BoxFit.cover,
                                                    gaplessPlayback: true,
                                                  )
                                                : Center(
                                                    child: Container(
                                                      width: ctr.maxWidth * 0.3,
                                                      height:
                                                          ctr.maxWidth * 0.3,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: Text(
                                              '${e['catgoryName']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.quicksand(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              }).toList()
                            ],
                          ),
                          WidgetSizeOffset(
                            globalKey: controller.globalKeyFilter,
                            onChange: (size, offset) {
                              controller.filterOriginPoint.value = offset.dy +
                                  controller.scrollController.offset;
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              // color: Colors.red,
                            ),
                          ),
                          //
                          if (controller.foodsShow.isEmpty)
                            Column(
                              children: [
                                Gap(40),
                                Image.asset(
                                  "assets/images/notfound.png",
                                  width: 75,
                                  height: 75,
                                  color: Colors.grey[600],
                                ),
                                const Gap(20),
                                Text(
                                  "No Result Found",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            )
                          else
                            Container(
                              child: Obx(
                                () {
                                  String searchVal =
                                      controller.searchFood.value;
                                  List searchFoodFilter =
                                      controller.foodsShow.where((food) {
                                    return food['foodName'].contains(searchVal);
                                  }).toList();
                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: searchFoodFilter.length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 0,
                                        color: Colors.grey,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return FoodItem(
                                        foodData: searchFoodFilter[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // if(false)
                  Obx(
                    () {
                      return Positioned(
                        top: math.max(
                            0,
                            ((controller.textFieldOriginPoint.value) -
                                    (MediaQuery.of(context).padding.top)) -
                                controller.scrollOffset.value),
                        height: 60,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Color(0xffE9EDF3),
                          // color: Colors.red,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: TextField(
                                cursorColor: Color(0xffFD7C4F),
                                style: GoogleFonts.quicksand(),
                                onChanged: (val) {
                                  controller.searchFood.value = val;
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search your favorite food',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 28,
                                    color: Color(0xffFD7C4F),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(top: (48 / 2)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () {
                      double val = math.max(
                          55,
                          ((controller.filterOriginPoint.value) -
                                  (MediaQuery.of(context).padding.top) +
                                  (15 / 2)) -
                              controller.scrollOffset.value);
                      return FilterBar(val: val);
                    },
                  ),
                  DraggableWidget(
                    bottomMargin: 90,
                    horizontalSpace: 10,
                    normalShadow: BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 0),
                      blurRadius: 0,
                    ),
                    draggingShadow: BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 0),
                      blurRadius: 0,
                    ),
                    child: Obx(
                      () {
                        if (controller.isShowMiniImage.value)
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                "assets/images/food-logo${controller.imageNo}.png",
                                width: 70,
                                height: 70,
                              ),
                              Positioned(
                                right: -5,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.isShowMiniImage.value = false;
                                    controller.timer?.cancel();
                                  },
                                  child: Image.asset(
                                    "assets/images/cancel.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        else
                          return Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
