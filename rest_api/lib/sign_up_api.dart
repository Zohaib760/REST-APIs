
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpApi extends StatefulWidget {
  const SignUpApi({super.key});

  @override
  State<SignUpApi> createState() => _SignUpApiState();
}

class _SignUpApiState extends State<SignUpApi> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  void login(email, password)async{
    try{
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : email,
            'password' : password
          },
          headers: {
          'x-api-key' : 'reqres-free-v1'
          }
      );
      if(response.statusCode == 200){
        print("Log in Successfully");
        print(response.body);
      }
      else{
        print("Log in failed");
        print(response.body);
      }
   }catch(e){
      print(e.toString());
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("log in API"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  label: Text('Email'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 4,
                    style: BorderStyle.solid

                  )
                )
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text('Password'),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 4,
                          style: BorderStyle.solid

                      )
                  )
              ),
            ),
            SizedBox(height: 30,),

            InkWell(
              onTap: (){
                login(emailController.text.toString() , passwordController.text.toString());


              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25)
                ),

                // width: MediaQuery.of(context).size.width,
                height: 50,
                child:  Center(child: Text("Log In",
                  style: TextStyle(color: Colors.white, fontWeight:
                  FontWeight.bold,
                  fontSize: 30
                  ),)),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
