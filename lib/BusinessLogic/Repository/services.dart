class Services {
  String getNewsApiUrl(String article) {
    return 'https://newsapi.org/v2/everything?q=$article&apiKey=22841dcf65514b339fb7960f8cfaef58';
  }
}
