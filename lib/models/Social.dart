class Social {
  int? id;
  String? userId;
  String? affirmationsCategoryId;
  String? gratitude;
  String? expressingGratitude;
  String? beforeExpressingGratitude;
  String? afterExpressingGratitude;
  Null? image;
  String? socialCommunity;
  String? clickLily;
  String? versionType;
  String? group;
  String? version;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? color;
  String? categoryImage;
  int? isLike;
  int? totalLike;
  int? totalComments;
  String? userName;

  Social(
      {this.id,
        this.userId,
        this.affirmationsCategoryId,
        this.gratitude,
        this.expressingGratitude,
        this.beforeExpressingGratitude,
        this.afterExpressingGratitude,
        this.image,
        this.socialCommunity,
        this.clickLily,
        this.versionType,
        this.group,
        this.version,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.color,
        this.categoryImage,
        this.isLike,
        this.totalLike,
        this.totalComments,
        this.userName});

  Social.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    affirmationsCategoryId = json['affirmations_category_id'];
    gratitude = json['gratitude'];
    expressingGratitude = json['expressing_gratitude'];
    beforeExpressingGratitude = json['before_expressing_gratitude'];
    afterExpressingGratitude = json['after_expressing_gratitude'];
    image = json['image'];
    socialCommunity = json['social_community'];
    clickLily = json['click_lily'];
    versionType = json['version_type'];
    group = json['group'];
    version = json['version'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    color = json['color'];
    categoryImage = json['category_image'];
    isLike = json['is_like'];
    totalLike = json['total_like'];
    totalComments = json['total_comments'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['affirmations_category_id'] = this.affirmationsCategoryId;
    data['gratitude'] = this.gratitude;
    data['expressing_gratitude'] = this.expressingGratitude;
    data['before_expressing_gratitude'] = this.beforeExpressingGratitude;
    data['after_expressing_gratitude'] = this.afterExpressingGratitude;
    data['image'] = this.image;
    data['social_community'] = this.socialCommunity;
    data['click_lily'] = this.clickLily;
    data['version_type'] = this.versionType;
    data['group'] = this.group;
    data['version'] = this.version;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['color'] = this.color;
    data['category_image'] = this.categoryImage;
    data['is_like'] = this.isLike;
    data['total_like'] = this.totalLike;
    data['total_comments'] = this.totalComments;
    data['user_name'] = this.userName;
    return data;
  }
}
