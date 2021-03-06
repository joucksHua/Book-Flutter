class Article {
  Article(
      {this.novelId,
      this.title,
      this.content,
      this.price,
      this.currentIndex,
      this.nextArticleId,
      this.preArticleId,
      this.nextLink,
      this.preLink,
      this.currentLink,
      this.sourceType});
  int id;
  int novelId;
  String title;
  String content;
  int price;
  int currentIndex;
  int nextArticleId;
  int preArticleId;

  String nextLink;
  String preLink;
  String currentLink;
  String sourceType;

  List<Map<String, int>> pageOffsets;

  Article.fromJson(Map data) {
    id = data['id'];
    novelId = data['novelId'];
    title = data['title'];
    content = data['content'];
    // content = '　　' + content;
    content = content.replaceAll('  ', '\n    ');
    price = data['price'];
    currentIndex = data['currentIndex'];
    nextArticleId = data['nextArticleId'];
    preArticleId = data['preArticleId'];
    nextLink = data['nextLink'];
    preLink = data['preLink'];
    currentLink = data['currentLink'];
    sourceType = data["sourceType"];
  }

  /// jsonDecode(jsonStr) 方法中会调用实体类的这个方法。如果实体类中没有这个方法，会报错。
  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["novelId"] = this.novelId;
    map["title"] = this.title;
    map["content"] = this.content;
    map["price"] = this.price;
    map["currentIndex"] = this.currentIndex;
    map["nextArticleId"] = this.nextArticleId;
    map["preArticleId"] = this.preArticleId;
    map["nextLink"] = this.nextLink;
    map["preLink"] = this.preLink;
    map["currentLink"] = this.currentLink;
    map["sourceType"] = this.sourceType;
    return map;
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.content.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}
