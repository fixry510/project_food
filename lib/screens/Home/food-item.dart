import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FoodItem extends StatelessWidget {
  final Map foodData;
  const FoodItem({Key? key, required this.foodData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat.simpleCurrency(
      locale: "th",
      decimalDigits: 0,
      name: "",
    );
    return Container(
      height: 130,
      width: double.infinity,
      // color: Colors.red,
      padding: EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 0,
        right: 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(bottom: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: foodData['imageFile'] == null
                ? Container()
                : Image.file(
                    foodData['imageFile'],
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
          ),
          const Gap(10),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: AutoSizeText(
                            "${foodData['foodName']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            presetFontSizes: [18, 16],
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffFD7C4F),
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                          child: Text(
                            "${priceFormat.format(foodData['price'])}฿",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Gap(5),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text(
                  //     "${foodData['price']}",
                  //     overflow: TextOverflow.ellipsis,
                  //     style: GoogleFonts.quicksand(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  const Gap(5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Color(0xffFD7C4F),
                        size: 15,
                      ),
                      const Gap(3),
                      Text("${foodData['foodScore']}"),
                      if (foodData['recommended']) ...[
                        const Gap(8),
                        Container(
                          width: 2,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color(0xff3D303A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Gap(8),
                        Text('Recommended')
                      ]
                    ],
                  ),
                  Gap(10),
                  Flexible(
                    child: Text(
                      "${foodData['description']}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.quicksand(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
