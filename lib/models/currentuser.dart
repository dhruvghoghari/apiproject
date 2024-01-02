class currentUser {
  int? id;
  String? title;
  int? price;
  int? quantity;
  int? total;
  double? discountPercentage;
  int? discountedPrice;
  String? thumbnail;

  currentUser(
      {this.id,
        this.title,
        this.price,
        this.quantity,
        this.total,
        this.discountPercentage,
        this.discountedPrice,
        this.thumbnail});

  currentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage'];
    discountedPrice = json['discountedPrice'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['discountPercentage'] = this.discountPercentage;
    data['discountedPrice'] = this.discountedPrice;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}