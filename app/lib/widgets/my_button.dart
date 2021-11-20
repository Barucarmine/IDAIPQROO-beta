import 'package:flutter/material.dart';



class MyButton extends StatelessWidget {

  final String text;
  final void Function()? onPressed;
  final Color color;

  MyButton({
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all( color ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      child: Container(
        height: 45,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( this.text ,
              style: TextStyle( fontSize: 16 ),
            ),
          ],
        )
      ),    
      onPressed: onPressed
    );
  }
}