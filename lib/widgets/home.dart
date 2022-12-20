import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:movie_app/models/movie_search.dart';
import 'package:http/http.dart' as http;
//json decode
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var moviesEditingController = TextEditingController();
  List<MovieSearch> _movies = [
    // {
    //   "Title": "Harry Potter and the Deathly Hallows: Part 2",
    //   "Year": "2011",
    //   "imdbID": "tt1201607",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Sorcerer's Stone",
    //   "Year": "2001",
    //   "imdbID": "tt0241527",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMzkyZGFlOWQtZjFlMi00N2YwLWE2OWQtYTgxY2NkNmM1NjMwXkEyXkFqcGdeQXVyNjY1NTM1MzA@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Chamber of Secrets",
    //   "Year": "2002",
    //   "imdbID": "tt0295297",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Prisoner of Azkaban",
    //   "Year": "2004",
    //   "imdbID": "tt0304141",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg"
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: moviesEditingController,
                  decoration: InputDecoration(hintText: "Enter movie name"),)),
                TextButton(onPressed: (){
                  //call the method (Future)
                  fetchMovies(moviesEditingController.text).then((value) {
                    setState(() {
                      _movies= value;
                    });
                  }
                  );

                }, child: Text("Search"))
              ],
            ),
          ),

          //expanded is the layout ratio=1
          Expanded(
            //listview automatically shows it in SingleChildScrollView
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_movies[index].title),
                      subtitle: Text(_movies[index].year),
                      trailing: Icon(Icons.chevron_right),
                      //url image
                      leading: Image.network(_movies[index].poster),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(imdbId: _movies[index].imdId,)));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  //future:asynchronously
  Future<List<MovieSearch>> fetchMovies(searchText) async {
    final response = await http
        .get(Uri.parse('http://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
