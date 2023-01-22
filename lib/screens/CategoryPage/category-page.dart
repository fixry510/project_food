import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_decision/screens/CategoryPage/category-page-controller.dart';
import 'package:project_decision/screens/Home/food-item.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryPageController>(
      init: CategoryPageController(),
      builder: (controller) => GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: Get.back,
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff3D303A),
              ),
            ),
            title: Text(
              '${Get.arguments['catgoryName']}',
              style: GoogleFonts.quicksand(
                color: Color(0xff3D303A),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
          ),
          backgroundColor: Color(0xffE9EDF3),
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
                const Gap(10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    cursorColor: Color(0xffFD7C4F),
                    style: GoogleFonts.quicksand(),
                    onChanged: (val) {
                      controller.searchVal.value = val;
                      controller.update();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.grey[400],
                      ),
                      contentPadding: EdgeInsets.only(top: (48 / 2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Obx(() {
                    String searchVal = controller.searchVal.value;
                    List searchFoodFilter = controller.foods.where((food) {
                      return food['foodName'].contains(searchVal);
                    }).toList();
                    return ListView.separated(
                      padding: EdgeInsets.only(
                          left: 10, right: 20, bottom: 60, top: 10),
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
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
