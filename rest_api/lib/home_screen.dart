import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'Models/model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  List<Model> postList = [];
  Future<List<Model>> getPostApi () async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode==200){
      for(Map i in data){
        postList.add(Model.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST APIs"),
        centerTitle: true,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(
          child: FutureBuilder(future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                }
                else{
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                      itemCount: postList.length,
                      itemBuilder: (context, index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            children: [
                              Text("User id :",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].userId.toString()),
                            ],
                          ),
                         
                          Row(
                            children: [
                               Text("Tittle : ",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString()),
                            ],
                          ),
                           Text("Body",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(postList[index].body.toString()),
                        ],),
                      ),
                    );
                  });
                }
              }
          ),
        )
        
      ],) ,
    );
  }
}