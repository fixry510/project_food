import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_decision/build-in-radio.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/screens/BottomSheetFilter/all-filter-controller.dart';
import 'package:project_decision/screens/Home/home-controller.dart';
import 'package:project_decision/screens/models/condition-model.dart';

class AllFilter extends StatelessWidget {
  const AllFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Container(
        width: Get.width,
        child: GetBuilder<AllFilterController>(
          init: AllFilterController(),
          builder: (controller) => SingleChildScrollView(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Filter',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Gap(20),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.isRecommanded = !controller.isRecommanded;
                        HapticFeedback.lightImpact();
                        controller.update();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Recommanded',
                            style: GoogleFonts.quicksand(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Transform.scale(
                            scale: 0.85,
                            child: CupertinoSwitch(
                              value: controller.isRecommanded,
                              activeColor: Color(0xffFD7C4F),
                              onChanged: (value) {
                                controller.isRecommanded = value;
                                controller.update();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.onCheckSort(!controller.isSort);
                      },
                      child: Row(
                        children: [
                          Text(
                            'Sort',
                            style: GoogleFonts.quicksand(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Transform.scale(
                            scale: 0.85,
                            child: CupertinoSwitch(
                              value: controller.isSort,
                              activeColor: Color(0xffFD7C4F),
                              onChanged: (value) {
                                controller.onCheckSort(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Gap(10),
                    AnimatedContainer(
                      duration: 150.milliseconds,
                      width: double.infinity,
                      // color: Colors.green,
                      height: controller.isSort ? 120 : 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  controller.isAsc = !controller.isAsc;
                                  HapticFeedback.lightImpact();
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Ascending',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Spacer(),
                                    Transform.scale(
                                      scale: 0.85,
                                      child: CupertinoSwitch(
                                        value: controller.isAsc,
                                        activeColor: Color(0xffFD7C4F),
                                        onChanged: (value) {
                                          controller.isAsc = value;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(10),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller
                                            .onSelectSortBy("Recommanded");
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Recommanded',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                          const Gap(10),
                                          BuildInRadio(
                                            isCheck: controller.sortByList
                                                .firstWhere((s) =>
                                                    s['name'] ==
                                                    "Recommanded")['select'],
                                            height: 20,
                                            width: 20,
                                            centerColor: Color(0xffFD7C4F),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(45),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller.onSelectSortBy("Price");
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text('Price',
                                                style: GoogleFonts.quicksand()),
                                          ),
                                          const Gap(10),
                                          BuildInRadio(
                                            isCheck: controller.sortByList
                                                .firstWhere((s) =>
                                                    s['name'] ==
                                                    "Price")['select'],
                                            height: 20,
                                            width: 20,
                                            centerColor: Color(0xffFD7C4F),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(15),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller.onSelectSortBy("Rating");
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Rating',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                          const Gap(10),
                                          BuildInRadio(
                                            isCheck: controller.sortByList
                                                .firstWhere((s) =>s['name'] =="Rating")['select'],
                                            height: 20,
                                            width: 20,
                                            centerColor: Color(0xffFD7C4F),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(45),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        controller.onSelectSortBy("Food");
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Food',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                          const Gap(10),
                                          BuildInRadio(
                                            isCheck: controller.sortByList
                                                .firstWhere((s) =>
                                                    s['name'] ==
                                                    "Food")['select'],
                                            height: 20,
                                            width: 20,
                                            centerColor: Color(0xffFD7C4F),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    const Gap(10),
                    Text(
                      "Price",
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(15),
                    GridView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1 / 0.5,
                        crossAxisSpacing: 5,
                      ),
                      children: [
                        ...controller.prices.map(
                          (checkPrice) {
                            bool isCheck = checkPrice['check'];
                            return GestureDetector(
                              onTap: () {
                                controller.onCheckPrice(checkPrice['symbol']);
                              },
                              child: AnimatedContainer(
                                duration: 150.milliseconds,
                                height: 35,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: isCheck ? Color(0xffFD7C4F) : null,
                                  border: isCheck
                                      ? null
                                      : Border.all(
                                          width: 1,
                                          color: Colors.grey[300]!,
                                        ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    checkPrice['symbol'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isCheck
                                          ? Colors.white
                                          : Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    const Gap(15),
                    Text(
                      "Rating",
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(15),
                    GridView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1 / 0.5,
                        crossAxisSpacing: 5,
                      ),
                      children: [
                        ...controller.ratings.map(
                          (rate) {
                            bool isCheck = rate['check'];
                            return GestureDetector(
                              onTap: () {
                                controller.onCheckRating(rate['symbol']);
                              },
                              child: AnimatedContainer(
                                duration: 150.milliseconds,
                                height: 35,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: isCheck ? Color(0xffFD7C4F) : null,
                                  border: isCheck
                                      ? null
                                      : Border.all(
                                          width: 1,
                                          color: Colors.grey[300]!,
                                        ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      rate['symbol'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isCheck
                                            ? Colors.white
                                            : Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Gap(5),
                                    Icon(
                                      Icons.star_rounded,
                                      color: isCheck
                                          ? Colors.white
                                          : Color(0xffFD7C4F),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    const Gap(15),
                    Text(
                      "Category",
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(15),
                    Container(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          ...controller.categoriesCheckes.map((cate) {
                            bool isCheck = cate['check'];
                            return GestureDetector(
                              onTap: () {
                                controller.onCheckCate(cate['catgoryName']);
                              },
                              child: AnimatedContainer(
                                duration: 150.milliseconds,
                                height: 35,
                                width: 105,
                                constraints: BoxConstraints(
                                  minWidth: 50,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: isCheck ? Color(0xffFD7C4F) : null,
                                  border: isCheck
                                      ? null
                                      : Border.all(
                                          width: 1,
                                          color: Colors.grey[300]!,
                                        ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    cate['catgoryName'],
                                    style: GoogleFonts.kanit(
                                      color: isCheck
                                          ? Colors.white
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                    const Gap(50),
                    Center(
                      child: Container(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xffFD7C4F),
                          ),
                          onPressed: () {
                            Get.find<FilterController>().setCondition(() {
                              return ConditionDetail(
                                isRecommanded: controller.isRecommanded,
                                isSort: SortDetail(active: controller.isSort, asc: controller.isAsc, sortBy: controller.getSelectSortCheckbox()),
                                prices: controller.getSelectPrices(),
                                ratings: controller.getSelectRatings(),
                                catgories: controller.getSelectCategory(),
                              );
                            });
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: GestureDetector(
                    onTap: (){
                      controller.onResetCondition();
                    },
                    child: Text(
                      "Reset",
                      style: GoogleFonts.quicksand(
                          color: Color(0xffFD7C4F), fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
