class ProductArguments {
  String cId;
  String sort;
  int page;
  int pageSize;
  ProductArguments(
      {this.cId = "", this.sort = "", this.page = 1, this.pageSize = 10});
}
