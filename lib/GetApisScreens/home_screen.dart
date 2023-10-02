import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:api/GetApiModels//PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> posts = [];
  Future<List<PostsModel>?> getApiData() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      posts.clear();
      var data = jsonDecode(response.body);
      for (Map i in data) {
        posts.add(PostsModel.fromJson(i));
      }

      return posts;
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Api Testing')),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getApiData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot);
                    return Text('Loading');
                  } else {
                    print(snapshot);
                    return ListView.builder(
                        itemBuilder: (context, index) => ListTile(

                              title: Text(posts[index].title.toString()),
                            ),
                        itemCount: posts.length);
                  }
                }),
          )
        ],
      ),
    );
  }
}
