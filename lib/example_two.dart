import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photoes> photoes = [];
  Future<List<Photoes>?> getApiPhotoes() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      for(Map i in data){
        Photoes ph = Photoes(title: i['title'], url: i['url']);
        photoes.add(ph);

      }
      return photoes;
    }else{
      print(response.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Example 2')),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getApiPhotoes(), builder: (context , snapshot){
              return ListView.builder(itemBuilder: (context , index) => ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_circle_right),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar( backgroundImage:  NetworkImage(snapshot.data![index].url)),
                  ],
                ),

                title: Text(snapshot.data![index].title.toString()),
              ) , itemCount: photoes.length,);
            }),
          )
        ],
      ),
    );
  }
}

class Photoes{
  String title , url ;
  Photoes({required this.title, required this.url});

}