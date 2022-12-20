import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  // const DetailPage({Key? key}) : super(key: key);
  final String imdbId;

  //constructor to pass object
  DetailPage({required this.imdbId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail"),),

      body: Column(
        children: [
          SizedBox(height: 40),
          //have to put widget. to call the global variable for stateful
          Text("This is the page for ${widget.imdbId}"),
        ],
      ),
    );
  }
}
