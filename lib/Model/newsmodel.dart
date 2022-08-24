class News {
  String author = '0',
      title = '0',
      description = '0',
      url = '0',
      urlToImage = '0',
      publishedAt = '0',
      content = '0';
  News(
      {
        required this.title,
        required this.author,
        required this.content,
        required this.description,
        required this.publishedAt,
        required this.url,
        required this.urlToImage});
  factory News.fromJson(Map<String, dynamic> data) {
    return News(
        title: data['title'] ?? '',
        author: data['author'] ?? '',
        content: data['content'] ?? '',
        description: data['description'] ?? '',
        publishedAt: data['publishedAt'] ?? '',
        url: data['url'] ?? '',
        urlToImage: data['urlToImage'] ?? '');
  }
  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "content": content,
    "description": description,
    "publishedAt": publishedAt,
    "url": url,
    "urlToImage": urlToImage,
  };
}
