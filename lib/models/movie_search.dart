//create class
class MovieSearch {
  //create property
  final String title;
  final String imdId;
  final String year;
  final String poster;
  final String type;

  //constructor
  MovieSearch({required this.title, required this.imdId, required this.year, required this.poster,required this.type});

  factory MovieSearch.fromJson(Map<String, dynamic> json) {
    return MovieSearch(
      //the right side
      title: json['Title'],
      imdId: json['imdbID'],
      year: json['Year'],
      poster: json['Poster'],
      type: json['Type']);
    }

      //    transform json array into a list of map, only do this method if in the UI have a ListView
    static List<MovieSearch> moviesFromJson(dynamic json) {
      //"Search" is the json's name
      //https://www.omdbapi.com/?s=Harry&apikey=87d10179
      var searchResult = json["Search"];
      if (searchResult != null) {
        var results = new List<MovieSearch>.empty(growable: true);
        searchResult.forEach((v) {
          results.add(MovieSearch.fromJson(v));
        });
        return results;
      }
      return new List<MovieSearch>.empty();
    }
  }
