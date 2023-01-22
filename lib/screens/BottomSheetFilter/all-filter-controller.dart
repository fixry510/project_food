import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/screens/Home/home-controller.dart';
import 'package:project_decision/screens/models/condition-model.dart';

class AllFilterController extends GetxController {
  List categoriesCheckes = [];
  bool isRecommanded = false;
  bool isSort = false;
  bool isAsc = true;

  List sortByList = [
    {"name": "Recommanded", "select": false},
    {"name": "Price", "select": false},
    {"name": "Rating", "select": false},
    {"name": "Food", "select": false},
  ];

  List prices = [
    {"symbol": "฿", "check": false},
    {"symbol": "฿฿", "check": false},
    {"symbol": "฿฿฿", "check": false},
    {"symbol": "฿,฿฿฿", "check": false},
    {"symbol": "฿฿,฿฿฿", "check": false},
  ];

  List ratings = [
    {"symbol": "1", "check": false},
    {"symbol": "2", "check": false},
    {"symbol": "3", "check": false},
    {"symbol": "4", "check": false},
    {"symbol": "5", "check": false},
  ];

  void onResetCondition() {
    isAsc = true;
    categoriesCheckes = [];
    isRecommanded = false;
    isSort = false;
    sortByList = [
      {"name": "Recommanded", "select": true},
      {"name": "Price", "select": false},
      {"name": "Rating", "select": false},
      {"name": "Food", "select": false},
    ];
    prices = [
      {"symbol": "฿", "check": false},
      {"symbol": "฿฿", "check": false},
      {"symbol": "฿฿฿", "check": false},
      {"symbol": "฿,฿฿฿", "check": false},
      {"symbol": "฿฿,฿฿฿", "check": false},
    ];
    ratings = [
      {"symbol": "1", "check": false},
      {"symbol": "2", "check": false},
      {"symbol": "3", "check": false},
      {"symbol": "4", "check": false},
      {"symbol": "5", "check": false},
    ];
    update();
  }

  void onCheckPrice(String symbol) {
    final priceCheck = prices.firstWhere((price) => price['symbol'] == symbol);
    priceCheck['check'] = !priceCheck['check'];
    update();
  }

  void onCheckRating(String symbol) {
    final rate = ratings.firstWhere((rate) => rate['symbol'] == symbol);
    rate['check'] = !rate['check'];
    update();
  }

  void onCheckCate(String cateName) {
    final rate =
        categoriesCheckes.firstWhere((c) => cateName == c['catgoryName']);
    rate['check'] = !rate['check'];
    update();
  }

  void onCheckSort(val) {
    isSort = val;
    Future.delayed(200.milliseconds, () {
      isAsc = true;
    });
    sortByList = [
      {"name": "Recommanded", "select": true},
      {"name": "Price", "select": false},
      {"name": "Rating", "select": false},
      {"name": "Food", "select": false},
    ];
    HapticFeedback.lightImpact();
    update();
  }

  void onSelectSortBy(name) {
    sortByList = [
      {"name": "Recommanded", "select": false},
      {"name": "Price", "select": false},
      {"name": "Rating", "select": false},
      {"name": "Food", "select": false},
    ];
    sortByList.firstWhere((element) => element['name'] == name)['select'] =
        true;
    update();
  }

  String getSelectSortCheckbox() {
    Map? sortDataCheck = sortByList.firstWhereOrNull((sortBy) {
      return sortBy['select'];
    });
    if (sortDataCheck != null) {
      return sortDataCheck['name'];
    } else {
      return "";
    }
  }

  List<String> getSelectPrices() {
    return prices
        .where((price) => price['check'])
        .map((price) => price['symbol'].toString().replaceAll(",", ""))
        .toList();
  }

  List<String> getSelectRatings() {
    return ratings
        .where((rate) => rate['check'])
        .map((rate) => rate['symbol'].toString())
        .toList();
  }

  List getSelectCategory() {
    return categoriesCheckes.where((cate) => cate['check']).toList();
  }

  // {isRecommanded: true, isSort: {active: true, asc: true, sortBy: Rating}, prices: [฿, ฿฿], ratings: [2], catgories: []}
  void initCondition() {
    ConditionDetail conditionDetail =
        Get.find<FilterController>().conditionDetail;
    isRecommanded = conditionDetail.isRecommanded;
    isSort = conditionDetail.isSort.active;
    isAsc = conditionDetail.isSort.asc;
    prices.forEach((price) {
      conditionDetail.prices.forEach((p) {
        if (price['symbol'].toString().replaceAll(",", "") == p) {
          price['check'] = true;
        }
      });
    });
    sortByList.forEach((sbl) {
      if (sbl['name'] == conditionDetail.isSort.sortBy) {
        sbl['select'] = true;
      }
    });
    ratings.forEach((rate) {
      conditionDetail.ratings.forEach((r) {
        if (rate['symbol'].toString() == r) {
          rate['check'] = true;
        }
      });
    });
    categoriesCheckes.forEach((cate) {
      conditionDetail.catgories.forEach((c) {
        if (cate['catgoryId'] == c['catgoryId']) {
          cate['check'] = true;
        }
      });
    });
  }

  @override
  void onInit() {
    super.onInit();
    categoriesCheckes = Get.find<HomeController>().categoriesData.map((cate) {
      return <String, dynamic>{
        ...cate,
        "check": false,
      };
    }).toList();
    initCondition();
  }
}
