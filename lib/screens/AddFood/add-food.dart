import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_decision/screens/AddFood/add-food-controller.dart';

class AddFood extends StatelessWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffE9EDF3),
        appBar: AppBar(
          backgroundColor: Color(0xffFD7C4F),
          // backgroundColor: Color(0xffFD7C4F),
          elevation: 2,
          title: Text(
            'Add Food',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: GetBuilder<AddFoodController>(
          init: AddFoodController(),
          builder: (controller) {
            return Container(
              // color: Colors.red,
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 80),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Container(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Category",
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Obx(
                                () => Stack(
                                  children: [
                                    Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: controller.errorCateSelect
                                                  .value.isNotEmpty
                                              ? 2
                                              : 1,
                                          color: controller.errorCateSelect
                                                  .value.isNotEmpty
                                              ? Colors.red[800]!
                                              : Colors.grey[400]!,
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 15),
                                      child: DropdownButton<Map>(
                                        value: controller.currentSelectCate,
                                        dropdownColor: Colors.white,
                                        onTap: () {
                                          controller.errorCateSelect.value = '';
                                        },
                                        icon: Transform.translate(
                                          offset: Offset(0, -3),
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 18,
                                              color: controller.errorCateSelect
                                                      .value.isNotEmpty
                                                  ? Colors.red[800]!
                                                  : Colors.grey[500]!,
                                            ),
                                          ),
                                        ),
                                        underline: Container(),
                                        isExpanded: true,
                                        selectedItemBuilder: (context) {
                                          return controller.categories
                                              .map((cate) {
                                            return Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    99,
                                                  ),
                                                  child: Image.file(
                                                    cate['imageFile'],
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  '${cate['catgoryName']}',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                              ],
                                            );
                                          }).toList();
                                        },
                                        items: controller.categories
                                            .map<DropdownMenuItem<Map>>((cate) {
                                          return DropdownMenuItem(
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          99999),
                                                  child: Image.file(
                                                    cate['imageFile'],
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  '${cate['catgoryName']}',
                                                  style:
                                                      GoogleFonts.quicksand(),
                                                ),
                                              ],
                                            ),
                                            value: cate,
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          controller.currentSelectCate = val;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 10,
                                      child: IgnorePointer(
                                        child: Center(
                                          child: Text(
                                            '${controller.errorCateSelect.value}',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14,
                                              color: Colors.red[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => getTextField(
                          text: "Name",
                          controller: controller.foodNameController,
                          errorText: controller.errorFoodName,
                          onTap: () {
                            controller.errorFoodName.value = '';
                          },
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => getTextField(
                          text: "Price",
                          controller: controller.priceController,
                          price: true,
                          errorText: controller.errorPrice,
                          onTap: () {
                            controller.errorPrice.value = '';
                          },
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'Description',
                        style: GoogleFonts.kanit(
                          fontSize: 18,
                        ),
                      ),
                      const Gap(5),
                      Obx(
                        () => getTextField(
                          multiLine: true,
                          hintText: 'About food...',
                          controller: controller.descriptionController,
                          errorText: controller.errorDescription,
                          onTap: () {
                            controller.errorDescription.value = '';
                          },
                        ),
                      ),
                      const Gap(15),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.selectImageFood();
                        },
                        child: Center(
                          child: Obx(
                            () => Container(
                              width: double.infinity,
                              height: Get.width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: controller.errorImage.value.isNotEmpty
                                      ? 2
                                      : 1,
                                  color: controller.errorImage.value.isNotEmpty
                                      ? Colors.red[800]!
                                      : Colors.grey[400]!,
                                ),
                              ),
                              child: controller.file != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        controller.file!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 30,
                                            color: controller
                                                    .errorImage.value.isNotEmpty
                                                ? Colors.red[800]!
                                                : Colors.grey[600]!,
                                          ),
                                          const Gap(5),
                                          Text(
                                            controller
                                                    .errorImage.value.isNotEmpty
                                                ? '${controller.errorImage.value}'
                                                : 'Add Food Image',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: controller.errorImage.value
                                                      .isNotEmpty
                                                  ? Colors.red[800]!
                                                  : Colors.grey[600]!,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(25),
                      Divider(
                        height: 0,
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Rating',
                              style: GoogleFonts.kanit(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Row(
                              children: [
                                Spacer(),
                                for (int i = 1; i <= 5; i++)
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.ratingNumber == i) {
                                        controller.ratingNumber = 1;
                                      } else {
                                        controller.ratingNumber = i;
                                      }
                                      HapticFeedback.lightImpact();
                                      controller.update();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: i <= controller.ratingNumber
                                            ? Icon(
                                                Icons.star_outlined,
                                                color: Color(0xffFD7C4F),
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.star_outline_rounded,
                                                color: Colors.grey[600],
                                                size: 30,
                                              ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
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
                      const Gap(30),
                      Center(
                        child: Container(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xffFD7C4F),
                            ),
                            onPressed: () {
                              controller.addFoodHandler();
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget getTextField({
  controller,
  text,
  multiLine = false,
  hintText = '',
  price = false,
  errorText = '',
  onTap,
}) {
  bool isError = errorText.toString().isNotEmpty;
  final pChangeFormat = NumberFormat.simpleCurrency(
    locale: "th",
    decimalDigits: 0,
    name: "",
  );
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (!multiLine)
        Expanded(
          flex: 2,
          child: Text(
            text,
            style: GoogleFonts.kanit(
              fontSize: 18,
            ),
          ),
        ),
      Expanded(
        flex: 6,
        child: Stack(
          children: [
            Container(
              height: multiLine ? 70 : 35,
              child: TextField(
                onTap: onTap,
                controller: controller,
                keyboardType: price ? TextInputType.number : null,
                maxLines: multiLine ? 3 : null,
                onChanged: (value) {
                  if (price && value.isNotEmpty) {
                    controller.text = pChangeFormat.format(double.parse(value.replaceAll(",", "")));
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length),
                    );
                  }
                },
                style: GoogleFonts.quicksand(),
                cursorColor: Color(0xffFD7C4F),
                inputFormatters: [
                  if (price) LengthLimitingTextInputFormatter(6),
                ],
                decoration: InputDecoration(
                  hintText: isError ? '' : hintText,
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.only(top: (30 / 2), left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: isError ? 2 : 1,
                      color: isError ? Colors.red[700]! : Colors.grey[400]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: isError ? Colors.red[700]! : Color(0xffFD7C4F),
                    ),
                  ),
                ),
              ),
            ),
            if (isError)
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Align(
                    alignment:
                        multiLine ? Alignment(-0.8, -0.8) : Alignment(0, .05),
                    child: Text(
                      '$errorText',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    ],
  );
}
