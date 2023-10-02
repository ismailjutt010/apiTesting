import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/GetApiModels//UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}
class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUserApi()async{
    var response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      for(Map i in data){
        usersList.add(UserModel.fromJson(i));
      }
      return usersList;
    }else{
      return usersList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Example Three')),),
      body: Column(
        children: [

          Expanded(child: FutureBuilder(future: getUserApi(), builder: (context , snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }else{
              return ListView.builder(itemCount: usersList.length,itemBuilder:(context , index)
              => Padding(

                  padding: EdgeInsets.all(10),
                child: Card(
                  child: Column(
                    children: [
                      ReUseAbleRow(title: 'Names', value: snapshot.data![index].name.toString()),
                      ReUseAbleRow(title: 'User Name', value: snapshot.data![index].username.toString()),
                      ReUseAbleRow(title: 'Email', value: snapshot.data![index].email.toString()),
                      ReUseAbleRow(title: 'City', value: snapshot.data![index].address!.city.toString()),

                    ],
                  ),
                ),
              )
              );
            }


          }))

        ],
      ),
    );
  }
}
class ReUseAbleRow extends StatelessWidget {
String title;
String value;
ReUseAbleRow({required this.title , required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

