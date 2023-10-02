import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/GetApiModels/ProductsModel.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {


  Future<ProductsModel> getProducts()async{
    var response = await http.get(Uri.parse('https://webhook.site/ced81a09-c542-4d49-afce-188d1b32727f'));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Example Four'))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: FutureBuilder(future: getProducts(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData){
                return ListView.builder(

                  itemCount: snapshot.data.data.length, itemBuilder:(context , index) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(snapshot.data.data[index].shop.name.toString()),
                          subtitle: Text(snapshot.data.data[index].shop.shopemail.toString()),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data.data[index].shop.image.toString()),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,

                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:snapshot.data.data[index].images.length, itemBuilder:(context , position){
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data.data[index].images[position].url.toString())

                                      )
                                  ),
                                ),
                              );
                            } )
                        ),
                        Icon(snapshot.data.data[index].inWishlist == false ? Icons.favorite : Icons.favorite_outline)
                      ],
                    ), );
              }else{
                return Text('Loading');
              }
            },))
          ],
        ),
      ),
    );
  }
}
