class SortDetail {
  late bool active;
  late bool asc;
  late String sortBy;
  SortDetail({required this.active, required this.asc, required this.sortBy});
}

class ConditionDetail {
  late final bool isRecommanded;
  late final SortDetail isSort;
  late final List<String> prices;
  late final List<String> ratings;
  late final List catgories;

  ConditionDetail({
    required this.catgories,
    required this.isRecommanded,
    required this.isSort,
    required this.prices,
    required this.ratings,
  });
  @override
  String toString() {
    return {
      "isRecommanded": this.isRecommanded,
      "isSort": {
        "active": this.isSort.active,
        "asc": this.isSort.asc,
        "sortBy": this.isSort.sortBy,
      },
      "prices": this.prices,
      "ratings": this.ratings,
      "catgories": this.catgories,
    }.toString();
  }
}

final defalut = ConditionDetail(
  isRecommanded: false,
  isSort: SortDetail(active: false, asc: true, sortBy: ""),
  ratings: [],
  prices: [],
  catgories: [],
);