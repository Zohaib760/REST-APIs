import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadingImage extends StatefulWidget {
  const UploadingImage({super.key});

  @override
  State<UploadingImage> createState() => _UploadingImageState();
}

class _UploadingImageState extends State<UploadingImage> {

  File? image;
 final _picker = ImagePicker();
 bool showSpinner = false;

 Future getImage()async{
   final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
   if(pickedFile!= null){
     image = File(pickedFile.path);
     setState(() {
     });
   }else{
     print("no image selected");
   }
 }
  Future takeImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {
      });
    }else{
      print("no image selected");
    }
  }

 Future <void> UploadImage() async{
   setState(() {
     showSpinner = true;
   });

   var stream = new http.ByteStream(image!.openRead());
   stream.cast();
   var length = await image!.length();

   var uri = Uri.parse('https://fakestoreapi.com/products');

   var request = new http.MultipartRequest("POST", uri);

   var multipartFile = new http.MultipartFile(
       'image',
       stream,
       length);

   request.files.add(multipartFile);

   var response = await request.send();

   if(response.statusCode==200){
     print("Image uploaded successfully");
     setState(() {
       showSpinner = false;
     });
   }else{
     setState(() {
       showSpinner = false;
     });
     print("failed");
   }

 }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Uploading Image '),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: image == null ? Center(child: Text("PIck an Image"),):
                   Container(child: Center(
                     child: Image.file(
                       height: 300,
                        width: 300,
                       fit: BoxFit.cover,
                       File(image!.path).absolute
      
                     ),
                   ),)
              ),
      SizedBox(height: 40,),
              InkWell(
                onTap: getImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                        
                  ),
                  height: 50,
                  child: Center(child: Text('Gallery' , style: TextStyle(fontSize: 25),),)
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: takeImage,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)

                    ),
                    height: 50,
                    child: Center(child: Text('Camera' , style: TextStyle(fontSize: 25),),)
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: UploadImage,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)

                    ),
                    height: 50,
                    child: Center(child: Text('Upload' , style: TextStyle(fontSize: 25),),)
                ),
              )
            ],
          ),
          
        ),
      ),
    );
  }
}
