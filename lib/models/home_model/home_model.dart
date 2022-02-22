class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }

}

class HomeDataModel {
  List<BannerModel>? banners = <BannerModel>[];
  List<ProductsModel>? products = <ProductsModel>[];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners!.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products!.add(ProductsModel.fromJson(element));
    });
  }


}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;

  ProductsModel(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.inFavorite,
      this.inCart});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }


}
