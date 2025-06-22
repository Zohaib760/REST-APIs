

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/Complex_Model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

   List<ComplexModel> userList = []; 
   
  Future<List<ComplexModel>> getUserAPI() async{
     final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
     
     if(response.statusCode==200){
       
       for(Map i in data){
        userList.add(ComplexModel.fromJson(i));
       }
       return userList;
     }else{
      return userList;
     }

 
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child:FutureBuilder(
            future: getUserAPI(), 
            builder: (context , AsyncSnapshot<List<ComplexModel>> snapshot){
              if(!snapshot.hasData){
                 return Center(
                   child: CircularProgressIndicator(
                    strokeAlign: 0,
                   ),
                 );
             }else{
                 return ListView.builder(
                         itemCount: userList.length,
                         itemBuilder: (context , index ){
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                              child: Column(children: [                    
                              ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
                              ReusableRow(title: "Username", value: snapshot.data![index].username.toString()),
                              ReusableRow(title: "Email", value: snapshot.data![index].email.toString()),
                              ReusableRow(title: "Address", value: snapshot.data![index].address!.city.toString()),
                              ReusableRow(title: "Phone", value: snapshot.data![index].phone.toString()),
                                              
                                              
                                               ],)
                                               ),
                         );
                }
                );
                      }
              
            }
           
            
            ) 
            )

      ],)
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({super.key, required this.title, required this.value});

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
    )              ;
  }
}