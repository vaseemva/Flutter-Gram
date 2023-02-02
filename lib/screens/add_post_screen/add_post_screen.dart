import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => AddPostScreenState(); 
}

class AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Uint8List? _file;
    return Scaffold(
        appBar: AppBar(),
        body: 
        _file==null? 
        // ListView(
          // children: [
          //   SizedBox(
          //     height: size.height * 0.05,
          //   ),
            
            GestureDetector(
              onTap: () async{
              Uint8List  file=await pickImage(ImageSource.gallery); 
                setState(() {
                  _file=file;
                });
              },
              child:Center(
                child: Container(
                  width: size.width * 0.55,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [ 
                      Icon(Icons.upload),
                      kHeight10,
                      Text('Add Thumbnail')
                    ],
                  ),
                ),
              )
              
            )
            
            // TextFormField()
        //   ],
        // )
        :Center(child: Container(
                width: size.width*0.55,
                height: size.height*0.15, 
                decoration: BoxDecoration(
                  image: DecorationImage(image: MemoryImage(_file),fit: BoxFit.fill)
                ),
              ),),); 
  }
}
 