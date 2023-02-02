import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/add_post_screen/add_post_screen.dart';

class AddPost extends StatelessWidget {
  const AddPost({
    Key? key,
    required this.size, required this.label, required this.iconData,
  }) : super(key: key);

  final Size size;
  final String label;
  final IconData iconData;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPostScreen(),));
      },
        
      
      child: Stack(
        children: [
          Container(
            height: size.height * 0.15,
            width: size.width * 0.30,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset:
                      const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.1,
            width: size.width * 0.30,
           
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45)),
            ),
          ),
          Positioned(
            top: 12,
            left: 35,  
            child: Icon(iconData,color: Colors.white,size: 40 ,)),
            Positioned(
              top: 85, 
              left: 15,
              child: Text(label,
              
              ))
        ],
      ),
    );
  }
  
}