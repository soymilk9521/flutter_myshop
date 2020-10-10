class ProductArguments {
  String cId;
  String sort;
  int page;
  int pageSize;
  bool flag;
  bool hasMore;
  String keywords;
  ProductArguments({
    this.cId = "",
    this.sort = "",
    this.page = 1,
    this.pageSize = 10,
    this.flag = true,
    this.hasMore = true,
    this.keywords = "",
  });
}
