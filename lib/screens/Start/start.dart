import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:phlox_animations/phlox_animations.dart';
import 'package:project_decision/screens/Start/start-controller.dart';

double toDegree(val) {
  return val * (math.pi / 180);
}

double height([val = 1]) {
  return (val * Get.height);
}

double width([val = 1]) {
  return val * Get.width;
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    return Scaffold(
      body: GetBuilder<StartController>(
        init: StartController(),
        builder: (controller) => Obx(() {
          double scrollOffset = controller.scrollOffset.value;
          var originalHeightScroll = height(50);
          final double speedForestV = 0.4;
          final double speedForestH = 0.2;
          final double speedBackGround = 0.43;
          final double speedMountainV = 0.35;
          final double speedMountainH = 0.1;
          final double speedSunV = 0.05;
          final double speedClondV = 0.05;
          final double speedClondH = 0.05;

          // iphone height is 844.0
          return Container(
            width: double.infinity,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0xff5995EA),
                  Color(0xffB4ECFF),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 100 + (speedSunV * scrollOffset),
                  right: 20,
                  // right: 20 + -(speedSunH * scrollOffset),
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 100,
                  child: Container(
                    color: Color(0xff123233),
                  ),
                ),
                Positioned(
                  top: 80 + -(scrollOffset * speedClondV),
                  left: 20 + -(scrollOffset * speedClondH),
                  width: 200,
                  child: Container(
                    child: Image.asset(
                      "assets/images/clound1.png",
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  right: -(scrollOffset * speedClondH),
                  width: 200,
                  child: Container(
                    child: Image.asset(
                      "assets/images/clound3.png",
                    ),
                  ),
                ),
                Positioned(
                  top: 520,
                  left: 20 + -(scrollOffset * speedClondH),
                  width: 100,
                  child: Container(
                    child: Image.asset(
                      "assets/images/clound4.png",
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 20 + -(scrollOffset * speedClondH),
                  width: 100,
                  child: Container(
                    child: Image.asset(
                      "assets/images/clound2.png",
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100 + (speedMountainV * scrollOffset),
                  left: -150 + -(speedMountainH * scrollOffset),
                  right: -150 + -(speedMountainH * scrollOffset),
                  child: Image.asset(
                    "assets/images/fuji.png",
                  ),
                ),
                Positioned(
                  bottom: 100 + (speedForestV * scrollOffset),
                  left: math.min(
                    0,
                    -(speedForestH * scrollOffset),
                  ),
                  right: math.min(
                    0,
                    -(speedForestH * scrollOffset),
                  ),
                  child: Container(
                    child: Image.asset(
                      "assets/images/forest.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  // bottom: 500,
                  bottom: (-(size.height * 999) + 100) +
                      (speedBackGround * scrollOffset),
                  height: size.height * 999,
                  right: 0,
                  left: 0,
                  // height: 500,
                  child: AnimatedContainer(
                    duration: 500.milliseconds,
                    decoration: BoxDecoration(
                      color: controller.endForestOffset.value > 0
                          ? controller.endAll.value <= height(0.05)
                              ? Color(0xffFAEBDB)
                              : Color(0xffFD7C4F)
                          : Color(0xff123233),
                      // Color(0xffFD7C4F)
                      // color: Colors.black,
                    ),
                  ),
                ),
                if (controller.endForestOffset.value > 0)
                  ...contentSection(scrollOffset),
                if (controller.endAll.value > 0) ...[
                  AnimatedPositioned(
                    duration: 0.milliseconds,
                    top: math.max(height(0.05),
                        (height() - (controller.endAll.value * 0.5))),
                    left: width(0.5) - 150,
                    width: 300,
                    height: 300,
                    child: Obx(
                      () => Image.asset(
                        "assets/images/food-logo${controller.imageNo}.png",
                      ),
                    ),
                  ),
                ],
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      controller.onGetStart();
                    },
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        width: size.width,
                        height: originalHeightScroll,
                        child: Column(
                          children: [
                            Spacer(),
                            SafeArea(
                              child: Container(
                                width: 200,
                                height: 50,
                                color: Colors.red,
                                alignment: Alignment.center,
                                child: Text('END SCROLL AREA'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (height() - (controller.endAll.value * 0.5) <= height(0.05))
                  AnimatedPositioned(
                    duration: 0.milliseconds,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 300,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          PhloxAnimations(
                            duration: 300.milliseconds,
                            wait: 100.milliseconds,
                            fromOpacity: 0,
                            toOpacity: 1,
                            fromY: 30,
                            toY: 0,
                            child: Container(
                              child: Text(
                                "Local\ncuisine and\nresturant",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merienda(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          PhloxAnimations(
                            duration: 300.milliseconds,
                            wait: 350.milliseconds,
                            fromOpacity: 0,
                            toOpacity: 1,
                            fromY: 30,
                            toY: 0,
                            child: Container(
                              width: 300,
                              child: Text(
                                "Japanese cuisine is world-famous, but there is so much food in Japan to try besides sushi! Of course",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          SafeArea(
                            child: PhloxAnimations(
                              duration: 200.milliseconds,
                              wait: 450.milliseconds,
                              fromOpacity: 0,
                              toOpacity: 1,
                              fromY: 30,
                              toY: 0,
                              child: Container(
                                width: 270,
                                height: 55,
                                child: ElevatedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Color(0xff3D303A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.onGetStart();
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Get Started',
                                          style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 0,
                                        bottom: 0,
                                        child: Center(
                                          child: RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(Icons.arrow_back_ios),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> contentSection(double scrollOffset) {
    final controller = Get.find<StartController>();
    final newOffsetRamen = (scrollOffset - controller.endForestOffset.value);
    final scrollSpeedRamen = newOffsetRamen * 0.175;

    double textY = 0;
    double logoOffset = 0;
    double textJapanOffset = 0;
    // ------
    double newOffsetSushi = 0;
    double fadeOutTextOffset = 0;
    double sushiInOffet = 0;
    double moveOut = 0;

    if (scrollSpeedRamen >= height(0.3)) {
      textY = (scrollSpeedRamen - height(0.3));
      print(textY);
    }

    if (scrollSpeedRamen >= height(0.5)) {
      logoOffset = (scrollSpeedRamen - height(0.5)) * 0.5;
      textJapanOffset = (scrollSpeedRamen - height(0.5)) * 0.5;
    }

    if (textJapanOffset >= height(0.1)) {
      if (controller.endRamenVal.value == 0) {
        controller.endRamenVal.value = newOffsetRamen;
      }
      newOffsetSushi = scrollOffset -
          (controller.endForestOffset.value + controller.endRamenVal.value);
    } else {
      controller.endRamenVal.value = 0;
      newOffsetSushi = 0;
    }

    if (newOffsetSushi >= height(0.2)) {
      fadeOutTextOffset = (newOffsetSushi - height(0.2)) * 0.2;
    }

    if (fadeOutTextOffset >= 200) {
      sushiInOffet = newOffsetSushi - (height(.2) + (200 / 0.2));
      sushiInOffet = sushiInOffet * 0.35;
    }

    if (sushiInOffet >= height(0.5)) {
      moveOut =
          newOffsetSushi - ((height(0.5) / 0.35) + (height(.2) + (200 / 0.2)));
      moveOut = moveOut * 0.35;
    }

    if (((moveOut / 0.35) - ((height(.2) + 630) / 0.35)) * 0.35 > height(0.5)) {
      controller.endAll.value = ((((moveOut / 0.35) - ((height(.2) + 630) / 0.35)) * 0.35) - height(0.5)) / 0.35;
      print(controller.endAll.value);
    } else {
      controller.endAll.value = 0;
    }

    double logoCenter = (width() / 2) - 50;
    return <Widget>[
      AnimatedPositioned(
        duration: 0.milliseconds,
        left: sushiInOffet > 0
            ? lerpDouble(logoCenter + logoOffset.clamp(0, 50), -70,
                sushiInOffet.clamp(0, 300) / 300)
            : logoCenter + logoOffset.clamp(0, 50),
        top: sushiInOffet > 0
            ? lerpDouble(height(0.3), -50, sushiInOffet.clamp(0, 300) / 300)
            : scrollSpeedRamen.clamp(0, height(0.3)),
        child: Opacity(
          opacity: moveOut > 0
              ? lerpDouble(1, 0, (moveOut * 1.2).clamp(0, 300) / 300)!
              : 1,
          child: Transform.rotate(
            angle: toDegree(lerpDouble(
                -180, 0, scrollSpeedRamen.clamp(0, height(0.3)) / height(0.3))),
            child: Transform.scale(
              scale: sushiInOffet > 0
                  ? lerpDouble(2, 5,
                      Curves.easeIn.transform(sushiInOffet.clamp(0, 300) / 300))
                  : lerpDouble(0.5, 2,
                      scrollSpeedRamen.clamp(0, height(0.3)) / height(0.3)),
              child: Image.asset(
                "assets/images/ramen.png",
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      ),
      if (sushiInOffet > 0)
        AnimatedPositioned(
          duration: 0.milliseconds,
          top: moveOut > 0 ? height(0.6) + -moveOut : height(0.6),
          right: lerpDouble(-width(0.8), 0,
              Curves.ease.transform(sushiInOffet.clamp(0, 300) / 300)),
          child: Image.asset(
            "assets/images/sushi-dish.png",
            width: width(0.8),
          ),
        ),
      if (sushiInOffet > 0) ...[
        AnimatedPositioned(
          duration: 0.milliseconds,
          top: moveOut > 0
              ? height(0.735) + -moveOut
              : lerpDouble(height(0.6), height(0.735), Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          right: lerpDouble(-100, width(0.33),
              Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          child: Transform.rotate(
            angle: toDegree(20),
            child: Image.asset(
              "assets/images/sushi-dish3.png",
              width: 135,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: 0.milliseconds,
          top: moveOut > 0
              ? height(0.69) + -moveOut
              : lerpDouble(height(0.55), height(0.69),
                  Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          right: lerpDouble(-200, width(0.13),
              Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          child: Transform.rotate(
            angle: toDegree(20),
            child: Image.asset(
              "assets/images/sushi-dish1.png",
              width: 135,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: 0.milliseconds,
          top: moveOut > 0
              ? height(0.64) + -moveOut
              : lerpDouble(height(0.5), height(0.64),
                  Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          right: lerpDouble(-300, -35,
              Curves.ease.transform(sushiInOffet.clamp(0, 400) / 400)),
          child: Transform.rotate(
            angle: toDegree(20),
            child: Image.asset(
              "assets/images/sushi-dish2.png",
              width: 135,
            ),
          ),
        ),
        getBoxAnimated(
            moveX: sushiInOffet,
            moveY: moveOut,
            startOffset: (height(0.5) - 75),
            isLeft: true,
            miniImg: "assets/images/food-logo1.png"),
        getBoxAnimated(
            moveX: moveOut >= height(.12)
                ? ((moveOut / 0.35) - (height(.12) / 0.35)) * 0.35
                : 0,
            moveY: moveOut >= height(.12)
                ? ((moveOut / 0.35) - (height(.12) / 0.35)) * 0.35
                : 0,
            lerpVal: 150,
            startOffset: height() - 150,
            isLeft: false,
            miniImg: "assets/images/food-logo2.png"),
        getImageAnimated(
          moveX: moveOut >= (height(.15))
              ? ((moveOut / 0.35) - ((height(.15)) / 0.35)) * 0.35
              : 0,
          moveY: moveOut >= (height(.06) + 150)
              ? ((moveOut / 0.35) - ((height(.06) + 150) / 0.35)) * 0.35
              : 0,
          lerpVal: 200,
          startOffset: height() - 150,
          imagePath: "assets/images/ramen3.png",
          w: 260,
          h: 260,
          rotate: 20,
        ),
        getBoxAnimated(
            moveX: (((moveOut / 0.35) - ((height(.15)) / 0.35)) * 0.35) > 180
                ? ((moveOut / 0.35) - ((height(.15) + 180) / 0.35)) * 0.35
                : 0,
            moveY: moveOut >= (height(.2) + 240)
                ? ((moveOut / 0.35) - ((height(.2) + 240) / 0.35)) * 0.35
                : 0,
            lerpVal: 200,
            startOffset: height() - 150,
            isLeft: true,
            miniImg: "assets/images/food-logo3.png"),
        getImageAnimated(
            moveX: ((moveOut / 0.35) - ((height(.15) + 180) / 0.35)) * 0.35 >
                    180
                ? ((moveOut / 0.35) - (((height(.15) + (180 * 2)) / 0.35))) *
                    0.35
                : 0,
            moveY: moveOut >= (height(.2) + 330)
                ? ((moveOut / 0.35) - ((height(.2) + 330) / 0.35)) * 0.35
                : 0,
            lerpVal: 200,
            startOffset: height() - 150,
            imagePath: "assets/images/food-img.png",
            w: 270,
            h: 270,
            isLeft: false),
        getBoxAnimated(
            moveX: ((moveOut / 0.35) - (((height(.15) + (180 * 2)) / 0.35))) * 0.35 >
                    180
                ? ((moveOut / 0.35) - (((height(.15) + (180 * 3)) / 0.35))) * 0.35
                : 0,
            moveY: moveOut >= (height(.2) + 550)
                ? ((moveOut / 0.35) - ((height(.2) + 550) / 0.35)) * 0.35
                : 0,
            lerpVal: 200,
            startOffset: height() - 150,
            isLeft: false,
            miniImg: "assets/images/food-logo4.png"),
        getImageAnimated(
          moveX: ((moveOut / 0.35) - (((height(.15) + (180 * 3)) / 0.35))) *
                      0.35 >
                  180
              ? ((moveOut / 0.35) - (((height(.15) + (180 * 4)) / 0.35))) * 0.35
              : 0,
          moveY: moveOut >= (height(.2) + 630)
              ? ((moveOut / 0.35) - ((height(.2) + 630) / 0.35)) * 0.35
              : 0,
          lerpVal: 200,
          startOffset: height() - 150,
          imagePath: "assets/images/food-last2.png",
          w: 280,
          h: 280,
          isLeft: true,
          rotate: 5,
          to: -50,
        ),
      ],
      if (scrollSpeedRamen >= height(0.5))
        Positioned(
          left: ((width() / 2) - 60) - textJapanOffset.clamp(0, 50),
          top: height(0.3),
          child: FractionalTranslation(
            translation: Offset(0, -0.28),
            child: Transform.scale(
              scale: lerpDouble(
                0.8,
                1,
                textJapanOffset.clamp(0, 50) / 50,
              ),
              child: Opacity(
                opacity: fadeOutTextOffset > 0
                    ? lerpDouble(1, 0, fadeOutTextOffset.clamp(0, 200) / 200)!
                    : textJapanOffset.clamp(0, 50) / 50,
                child: Text(
                  'ラーメン'.split("").join("\n"),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.caveat(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      if (scrollSpeedRamen >= height(0.3))
        AnimatedPositioned(
          duration: 0.milliseconds,
          top: height(0.6),
          left: 0,
          right: 0,
          child: Center(
            child: Transform.translate(
              offset: Offset(0, -(textY.clamp(0, 50).toDouble())),
              child: Opacity(
                opacity: fadeOutTextOffset > 0
                    ? lerpDouble(1, 0, fadeOutTextOffset.clamp(0, 200) / 200)!
                    : lerpDouble(0, 1, textY.clamp(0, 50) / 50)!,
                child: Text(
                  'Enjoy Delicious With\nJapanese Food',
                  // 'ラーメン'.split("").join("\n"),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merienda(
                    fontSize: 30,
                    color: Colors.black,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
    ];
  }

  Widget getBoxAnimated({
    required double moveX,
    required double moveY,
    required double startOffset,
    required String miniImg,
    bool isLeft = true,
    double speed = 1,
    double lerpVal = 400,
  }) {
    return Positioned(
      height: 150,
      width: width(0.9),
      top: moveY > 0 ? startOffset + -moveY : startOffset,
      left: isLeft
          ? lerpDouble(-(width(0.9)), 0,
              Curves.ease.transform(moveX.clamp(0, lerpVal) / lerpVal))
          : null,
      right: !isLeft
          ? lerpDouble(-(width(0.9)), 0,
              Curves.ease.transform(moveX.clamp(0, lerpVal) / lerpVal))
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff3D303A),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isLeft ? 10 : 0),
            bottomRight: Radius.circular(isLeft ? 10 : 0),
            topLeft: Radius.circular(!isLeft ? 10 : 0),
            bottomLeft: Radius.circular(!isLeft ? 10 : 0),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, ctr) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment:
                      isLeft ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Experience Authentic Taste\nOf Our Sushi and Japanese\nCuisine.',
                      textAlign: isLeft ? TextAlign.start : TextAlign.end,
                      style: GoogleFonts.merienda(
                        fontSize: 18,
                        // color: Color(0xffE28A3C),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: 0.milliseconds,
                  top: -75 / 2,
                  left: isLeft
                      ? lerpDouble(-75, ctr.maxWidth - (75 / 2),
                          Curves.ease.transform((moveX).clamp(0, 400) / 400))
                      : null,
                  right: !isLeft
                      ? lerpDouble(-75, ctr.maxWidth - (75 / 2),
                          Curves.ease.transform((moveX).clamp(0, 400) / 400))
                      : null,
                  child: Image.asset(
                    // "assets/images/food-logo${Get.find<HomeController>().imageNo.value}.png",
                    miniImg,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getImageAnimated(
      {required double moveX,
      required double moveY,
      required double startOffset,
      bool isLeft = true,
      required String imagePath,
      required double w,
      required double h,
      double speed = 1,
      double rotate = 0,
      double lerpVal = 400,
      double? to}) {
    return Positioned(
      width: w,
      height: h,
      top: moveY > 0 ? startOffset + -moveY : startOffset,
      left: isLeft
          ? lerpDouble(-w, to ?? 0,
              Curves.ease.transform(moveX.clamp(0, lerpVal) / lerpVal))
          : null,
      right: !isLeft
          ? lerpDouble(
              -w, 0, Curves.ease.transform(moveX.clamp(0, lerpVal) / lerpVal))
          : null,
      child: Transform.rotate(
        angle: toDegree(rotate),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
