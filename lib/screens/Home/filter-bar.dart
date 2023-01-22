import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/screens/BottomSheetFilter/all-filter.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    Key? key,
    required this.val,
  }) : super(key: key);

  final double val;

  @override
  Widget build(BuildContext context) {
    final conditionController = Get.find<FilterController>();
    final conditionDetail = conditionController.conditionDetail;
    return Positioned(
      top: val,
      height: 55,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffE9EDF3),
          boxShadow: val <= 55
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 4),
                    blurRadius: 3,
                  )
                ]
              : null,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 22, right: 15),
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(
                    AllFilter(),
                    isScrollControlled: true,
                    barrierColor: Colors.black38,
                    enableDrag: false,
                  );
            },
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 35,
                  decoration: BoxDecoration(
                    color: conditionController.isCondition()
                        ? Color(0xffFD7C4F)
                        : null,
                    border: conditionController.isCondition()
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Center(
                    child: Image.asset(
                      "assets/images/filter.png",
                      width: 20,
                      height: 20,
                      color: conditionController.isCondition()
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
                const Gap(8),
                Container(
                  // width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color: conditionDetail.catgories.length > 0
                        ? Color(0xffFD7C4F)
                        : null,
                    border: conditionDetail.catgories.length > 0
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: conditionDetail.catgories.length > 0 ? 15 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Category',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: conditionDetail.catgories.length > 0
                              ? Colors.white
                              : null,
                        ),
                      ),
                      if (conditionDetail.catgories.length > 0) ...[
                        const Gap(5),
                        Transform.translate(
                          offset: Offset(0, 1),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "${conditionDetail.catgories.length}",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const Gap(8),
                Container(
                  // width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color: conditionDetail.prices.length > 0
                        ? Color(0xffFD7C4F)
                        : null,
                    border: conditionDetail.prices.length > 0
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: conditionDetail.prices.length > 0 ? 15 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: conditionDetail.prices.length > 0
                              ? Colors.white
                              : null,
                        ),
                      ),
                      if (conditionDetail.prices.length > 0) ...[
                        const Gap(5),
                        Transform.translate(
                          offset: Offset(0, 1),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "${conditionDetail.prices.length}",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                    const Gap(8),
                Container(
                  // width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color: conditionDetail.ratings.length > 0
                        ? Color(0xffFD7C4F)
                        : null,
                    border: conditionDetail.ratings.length > 0
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: conditionDetail.ratings.length > 0 ? 15 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Rating',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: conditionDetail.ratings.length > 0
                              ? Colors.white
                              : null,
                        ),
                      ),
                      if (conditionDetail.ratings.length > 0) ...[
                        const Gap(5),
                        Transform.translate(
                          offset: Offset(0, 1),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "${conditionDetail.ratings.length}",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: conditionDetail.ratings.length > 0
                                      ? null :
                                       Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const Gap(8),
                Container(
                  // width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color:
                        conditionDetail.isRecommanded ? Color(0xffFD7C4F) : null,
                    border: conditionDetail.isRecommanded
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'Recommanded',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            conditionDetail.isRecommanded ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
