import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

class ExapmleTwo extends StatefulWidget {
  const ExapmleTwo({super.key});

  @override
  State<ExapmleTwo> createState() => _ExapmleTwoState();
}

class _ExapmleTwoState extends State<ExapmleTwo> {
   List<Photos> photosList = [];

  Future<List<Photos>> getPhotos () async{
     
     final respnse = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
     var data = jsonDecode(respnse.body.toString());
     
     if(respnse.statusCode==200){    
       for(Map i in data){
        Photos photo = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photo);
       }
       return photosList;
     }
     else{
      return photosList;
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api "),
        centerTitle: true,

      ),
      body: Column(children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
             builder: (context, AsyncSnapshot<List<Photos>>snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    subtitle: Text("ID : ${snapshot.data![index].id}"),
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
                    title: Text(snapshot.data![index].title.toString())
                  );
                });
             }),
          )

      ],),
    );
  }
}

class Photos{
  String title , url ;
  int id ;

  Photos({required this.title, required this.url, required this.id});
}