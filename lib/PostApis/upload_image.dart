import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future pickImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    if(pickedFile!=null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print('No Image Selected');
    }

  }
 Future<void> uploadImage()async{
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";
    
    var multiport = new http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();
    if(response.statusCode == 200){
      print('Image Uploaded Successfully');
      setState(() {
        showSpinner = false;
      });

    }else{
      setState(() {
        showSpinner = false;
      });
      print('Failed');
    }
 }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Center(
          child: Text('Upload Image'),
        ),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                pickImage();
              },
              child: Container(
                child: image == null ? Center(child: Text('Pick Image'),) :
                       Container(
                         child: Center(
                           child: Image.file(File(image!.path).absolute,
                           height: 100,
                             width: 100,
                             fit: BoxFit.cover,
                           ),
                         ),
                       )
              ),
            ),
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )

          ],
        ),
      ),
    );
  }
}
