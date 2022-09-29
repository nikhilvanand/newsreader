class Services {
  String getNewsApiUrl(String article) {
    if (article == '') {
      return 'https://newsapi.org/v2/top-headlines?country=in&apiKey=22841dcf65514b339fb7960f8cfaef58';
    }
    return 'https://newsapi.org/v2/everything?q=$article&apiKey=22841dcf65514b339fb7960f8cfaef58';
  }
}
